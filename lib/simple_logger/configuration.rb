module SimpleLogger
  class Configuration
    attr_writer :http_auth_user, :http_auth_password, :enabled, :simple_logger_url, :batch_size

    def batch_size
      @batch_size ||= 5
    end

    def simple_logger_url
      @simple_logger_url ||= 'fake'
    end

    def url
      if @url.nil?
        @url = URI.parse(simple_logger_url)
        @url.userinfo = @http_auth_user
        @url.password = @http_auth_password
      end
      @url
    end

    def enabled
      @enabled.nil? ? (@enabled = true) : @enabled
    end

    def enabled?
      enabled
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
