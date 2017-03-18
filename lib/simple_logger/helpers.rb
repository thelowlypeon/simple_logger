module SimpleLogger
  class Helpers
    class << self
      def symbolize_keys(hash)
        hash.inject({}){|h,(k,v)| h[k.to_sym] = v; h}
      end
    end
  end
end
