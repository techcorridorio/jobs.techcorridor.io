require 'uri'

module JobEngine
  class Position
    def self.null
      new({})
    end

    attr_reader :path, :source_path, :updated_at, :source_url, :featured, :title, :type, :company, :company_url, :location

    def initialize(data)
      @path = data[:path]
      @source_path = data[:source_path]
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
end

module JobEngine
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
        source_path: source_path,
        updated_at: updated_at,
      }
    end

    def source_path
      @resource.source_file.sub(%r{^/src/}, '')
    end

    def updated_at
      File.mtime(@resource.source_file)
    end
  end
end

module JobEngine
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
end

require 'forwardable'

module JobEngine
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
end

module JobEngine
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

    def new_position_url
      "#{github_url}/new/master/source/positions?filename=my_position.html.md"
    end

    def edit_position_url(position)
      "#{github_url}/edit/master/#{position.source_path}"
    end

    def delete_position_url(position)
      "#{github_url}/delete/master/#{position.source_path}"
    end

    private

    def github_url
      @context.config.github_url
    end
  end
end

module JobEngine
  module MiddlemanHelpers
    def job_engine
      JobEngine.new(self)
    end
  end
end
