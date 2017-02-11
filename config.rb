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

require 'uri'

class Position
  def self.null
    new({})
  end

  attr_reader :path, :source_url, :featured, :title, :type, :company, :company_url, :location

  def initialize(data)
    @path = data[:path]
    @source_url = data[:source_url]
    @featured = data[:featured]
    @title = data[:title]
    @type = data[:type]
    @company = data[:company]
    @company_url = data[:company_url]
    @location = data[:location]
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
        merge(path: @resource.path)

      Position.new(data)
    else
      Position.null
    end
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

class PositionCollection
  attr_reader :positions

  def initialize(positions)
    @positions = positions
  end

  def count
    @positions.length
  end

  def all
    @positions
  end

  def featured
    @positions.select { |position| position.featured? }
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

module JobEngineHelpers
  def job_engine
    JobEngine.new(self)
  end
end

# Methods defined in the helpers block are available in templates
helpers JobEngineHelpers

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
