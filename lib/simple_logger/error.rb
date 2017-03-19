module SimpleLogger
  class Error < Loggable
    attr_reader :exception

    def initialize(exception)
      @exception = exception
      super(error: exception.class, message: exception.to_s)
    end

    def type
      :error
    end
  end
end
