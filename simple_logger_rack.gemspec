$:.push File.expand_path("../lib", __FILE__)
require "simple_logger/version"

Gem::Specification.new 'simple_logger_rack', SimpleLogger::VERSION do |s|
  s.authors     = ["Peter Compernolle"]
  s.homepage    = "https://github.com/thelowlypeon/simple_logger_rack"
  s.summary     = "Simple logging service for Rack applications"
  s.description = "Server side requests, errors, and events, logged asynchronously"
  s.license     = 'MIT'
  s.files       = Dir["lib/**/*"]
  s.test_files  = Dir["spec/**/*"]

  s.add_dependency 'rack', '~> 2.0'
  s.add_development_dependency 'rspec'
end
