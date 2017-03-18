module SimpleLogger
  class Configuration
    attr_writer :url, :batch_size

    def batch_size
      @batch_size ||= 5
    end

    def url
      @url ||= URI.parse('http://fake.com')
    end
  end

  class << self
    attr_writer :config

    def config
      @configuration ||= Configuration.new
    end

    def configure
      yield(config)
    end
  end
end
