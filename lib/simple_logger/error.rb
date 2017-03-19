module SimpleLogger
  class Error < Loggable
    def initialize(exception)
      super({
        error: exception.class,
        message: exception.to_s,
        backtrace: exception.backtrace
      })
    end

    def type
      :error
    end
  end
end
