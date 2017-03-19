require 'net/http'
require 'json'

module SimpleLogger
  class Batch
    def initialize(data)
      @data = data
    end

    def deliver
      if false && SimpleLogger.config.deliver_async?
        Thread.new do
          deliver!
        end
      else
        deliver!
      end
    end

    private

    def serialized_data
      { logs: @data.map{|log| log.serialize.merge(log.meta)}.to_json }
    end

    def deliver!
      Net::HTTP.post_form(SimpleLogger.config.url, serialized_data) unless @data.empty?
    rescue
      nil
    end
  end
end
