module SimpleLogger
  class Loggable
    attr_accessor :timestamp

    def initialize(data = {})
      @data = SimpleLogger::Helpers.symbolize_keys(data)
      @timestamp = Time.now
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
      { type: type, timestamp: timestamp.utc, unixtime: timestamp.to_f }
    end
  end
end
