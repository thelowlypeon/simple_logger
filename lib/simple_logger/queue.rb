module SimpleLogger
  class Queue
    def initialize
      @requests = []
    end

    def log(entry)
      case entry
      when Request
        requests << entry
      end
    end

    def pending
      { requests: requests }
    end

    private

    attr_accessor :requests
  end
end
