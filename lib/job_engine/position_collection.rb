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
