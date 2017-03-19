module SimpleLogger
  class Queue
    def initialize
      reset
    end

    def log(entry)
      logs << entry

      deliver! unless count < SimpleLogger.config.batch_size
    end

    def pending
      logs
    end

    def count
      pending.count
    end

    def reset
      self.logs = []
    end

    def deliver!
      SimpleLogger::Batch.new(empty_queue).deliver
    end

    private

    attr_accessor :logs

    def empty_queue
      data = pending
      reset
      data
    end
  end
end
