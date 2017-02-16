require 'ostruct'
require 'uri'

module JobEngine
  class Position
    def self.null
      OpenStruct.new
    end

    attr_reader :path, :source_path, :updated_at, :source_url, :featured, :title, :type, :company, :company_url, :location

    def initialize(data)
      @featured = data[:featured]

      @path = data[:path]
      @source_path = data[:source_path]
      @updated_at = data[:updated_at]
      @source_url = data[:source_url]
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

    alias_method :atom_title, :page_title

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
