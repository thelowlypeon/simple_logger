module SimpleLogger
  module Rack
    class Middleware
      attr_reader :app, :queue

      def initialize(app)
        @app = app
        @queue = SimpleLogger::Queue.new
      end

      def call(env)
        return app.call(env) unless SimpleLogger.config.enabled?

        begin
          status, headers, response = app.call(env)
          queue.log(SimpleLogger::Rack::Request.new(env: env, status: status, headers: headers))
          [status, headers, response]
        rescue StandardError => e
          queue.log(SimpleLogger::Error.new(e))
          raise e
        end
      end
    end
  end
end
