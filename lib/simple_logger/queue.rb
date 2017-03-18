module SimpleLogger
  class Queue
    def initialize
      reset
    end

    def log(entry)
      case entry
      when Request
        requests << entry
      end

      deliver! unless count < SimpleLogger.config.batch_size
    end

    def pending
      { requests: requests }
    end

    def count
      pending.values.flatten(1).count
    end

    def reset
      self.requests = []
    end

    def deliver!
      SimpleLogger::Batch.new(empty_queue).deliver
    end

    private

    attr_accessor :requests

    def empty_queue
      data = pending
      reset
      data
    end
  end
end
