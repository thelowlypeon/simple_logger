module SimpleLogger
  class Helpers
    class << self
      def symbolize_keys(hash)
        if hash.is_a?(Hash)
          hash.inject({}){|h,(k,v)| h[k.to_sym] = v; h}
        else
          hash
        end
      end
    end
  end
end
