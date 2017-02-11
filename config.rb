###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

page '/positions/index.html', layout: 'layout'
page '/positions/*', layout: 'position'

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

module JobEngine
  require 'uri'

  class Position
    def self.null
      new({})
    end

    attr_reader :path, :updated_at, :source_url, :featured, :title, :type, :company, :company_url, :location

    def initialize(data)
      @path = data[:path]
      @updated_at = data[:updated_at]
      @source_url = data[:source_url]
      @featured = data[:featured]
      @title = data[:title]
      @type = data[:type]
      @company = data[:company]
      @company_url = data[:company_url]
      @location = data[:location]
    end

    def guid
      @guid ||= File.basename(path).split('.').first
    end

    def page_title
      if title && company
        "#{title} at #{company}"
      end
    end

    def featured?
      !!@featured
    end

    def absolute_path
      "/#@path"
    end

    def has_source_url?
      !!@source_url
    end

    def source_hostname
      if has_source_url?
        uri = URI.parse(@source_url)
        uri.hostname
      end
    end
  end

  class PositionFactory
    def initialize(resource)
      @resource = resource
    end

    def position
      if @resource.data[:position]
        data = @resource.
          data[:position].
          merge(extended_data)

        Position.new(data)
      else
        Position.null
      end
    end

    private

    def extended_data
      {
        path: @resource.path,
        updated_at: updated_at,
      }
    end

    def updated_at
      File.mtime(@resource.source_file)
    end
  end

  class PositionCollectionFactory
    def initialize(resources)
      @resources = resources
    end

    def position_collection
      positions = @resources.
        select { |resource| resource.data[:position] }.
        map { |resource| PositionFactory.new(resource).position }

      PositionCollection.new(positions)
    end
  end

  require 'forwardable'

  class PositionCollection
    extend Forwardable
    include Enumerable

    def_delegators :@positions, :each, :empty?

    attr_reader :positions

    def initialize(positions)
      @positions = positions
    end

    def count
      @positions.length
    end

    def reverse_chronological
      wrap(@positions.sort_by { |position| position.updated_at }.reverse)
    end

    def featured
      wrap(@positions.select { |position| position.featured? })
    end

    private

    def wrap(array)
      self.class.new(array)
    end
  end

  class JobEngine
    def initialize(context)
      @context = context
    end

    def position
      PositionFactory.new(@context.current_page).position
    end

    def positions
      PositionCollectionFactory.new(@context.sitemap.resources).position_collection
    end
  end

  module MiddlemanHelpers
    def job_engine
      JobEngine.new(self)
    end
  end
end

# Methods defined in the helpers block are available in templates
helpers JobEngine::MiddlemanHelpers

configure :development do
  activate :google_analytics do |ga|
    ga.tracking_id = false
  end
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript

  activate :google_analytics do |ga|
    ga.tracking_id = 'UA-91743483-1'
  end
end
