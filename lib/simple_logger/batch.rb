require 'net/http'

module SimpleLogger
  class Batch
    def initialize(data)
      @data = data
    end

    def deliver(async: true)
      if async
        Thread.new do
          deliver!
        end
      else
        deliver!
      end
    end

    private

    def deliver!
      return unless SimpleLogger.config.enabled?
      Net::HTTP.post_form(SimpleLogger.config.url, @data) unless @data.empty?
    end
  end
end
