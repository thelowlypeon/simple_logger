require 'bundler/setup'
Bundler.setup

require 'simple_logger_rack'

RSpec.configure do |config|
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true
end
