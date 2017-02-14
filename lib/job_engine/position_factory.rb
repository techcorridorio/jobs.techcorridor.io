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
