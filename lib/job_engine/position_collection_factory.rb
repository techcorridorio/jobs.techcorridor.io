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
