require 'net/http'

module SimpleLogger
  class Batch
    def initialize(data)
      @data = data
    end

    def deliver
      return unless SimpleLogger.config.enabled?
      if SimpleLogger.config.deliver_async?
        Thread.new do
          deliver!
        end
      else
        deliver!
      end
    end

    private

    def deliver!
      Net::HTTP.post_form(SimpleLogger.config.url, @data) unless @data.empty?
    rescue
      nil
    end
  end
end
