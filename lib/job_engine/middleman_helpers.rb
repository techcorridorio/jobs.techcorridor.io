module JobEngine
  module MiddlemanHelpers
    def job_engine
      JobEngine.new(self)
    end
  end
end
