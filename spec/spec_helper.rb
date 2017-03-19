require 'bundler/setup'
Bundler.setup

require 'simple_logger'

module SimpleLoggingHelpers
  def configure_authorized_appliation
    SimpleLogging.configure do |c|
      c.application = 'My application'
      c.key = 'my application key'
    end
  end
end

RSpec.configure do |c|
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true
  c.include SimpleLoggingHelpers
end
