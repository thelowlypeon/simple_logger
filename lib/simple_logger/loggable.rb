module SimpleLogger
  class Loggable
    def initialize(data = {})
      @data = SimpleLogger::Helpers.symbolize_keys(data)
      @timestamp = Time.now.utc
    end

    def type
      :loggable
    end

    def ignore?
      false
    end

    def value_for(key)
      @data[key]
    end

    def serialize
      @data
    end

    def meta
      { type: type, timestamp: timestamp }
    end
  end
end
