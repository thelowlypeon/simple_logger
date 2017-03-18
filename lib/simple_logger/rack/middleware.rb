module SimpleLogger
  module Rack
    class Middleware
      attr_reader :app, :queue

      def initialize(app)
        @app = app
        @queue = SimpleLogger::Queue.new
      end

      def call(env)
        status, headers, response = app.call(env)
        queue.log(SimpleLogger::Rack::Request.new(env: env, status: status, headers: headers))
        [status, headers, response]
      end
    end
  end
end
