module SimpleLogger
  module Rack
    class Request < SimpleLogger::Request
      ENV_KEY_MAP = {
        'REQUEST_METHOD'       => :method,
        'QUERY_STRING'         => :query,
        'HTTP_USER_AGENT'      => :user_agent,
        'HTTP_ACCEPT_LANGUAGE' => :language,
        'PATH_INFO'            => :path,
        'REMOTE_ADDR'          => :remote_ip,
        'HTTP_ACCEPT_ENCODING' => :encoding,
        'HTTP_ACCEPT'          => :content_type
      }

      def initialize(env:, status:, headers:)
        opts = filter_env(env)
          .merge(:status => status)
          .merge(headers)
        super(opts)
      end

      private

      def filter_env(env)
        Hash[
          env.map do |k, v|
            [ENV_KEY_MAP[k] || k, v]
          end
        ]
      end
    end
  end
end
