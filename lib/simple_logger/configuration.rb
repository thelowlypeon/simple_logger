module SimpleLogger
  class Configuration
    attr_writer :http_auth_user,
                :http_auth_password,
                :enabled,
                :simple_logger_url,
                :batch_size,
                :deliver_async,
                :ignore,
                :ignore_paths

    def batch_size
      @batch_size ||= 5
    end

    def simple_logger_url
      @simple_logger_url ||= 'https://my.simple_logger.url'
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
      @enabled = true if @enabled.nil?
      @enabled
    end

    def enabled?
      enabled
    end

    def ignore?
      @ignore ||= lambda { |loggable| false }
    end

    def ignore_paths
      @ignore_paths ||= /^\/(public|images|assets|css|favicon|scripts)/
    end

    def deliver_async?
      @deliver_async = true if @deliver_async.nil?
      @deliver_async
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
