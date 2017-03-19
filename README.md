# Simple Logger (for Rack applications)

Asynchronously send request logs and errors to Simple Logger for your Ruby web app.

Note: This currently only supports Rack based applications.

## Installation

Add the following to your Rack application's `Gemfile`:

```ruby
# Gemfile
gem 'simple_logger', git: 'https://github.com/thelowlypeon/simple_logger'
```

If you're running your application with a `config.ru`, simply require `simple_logger/rack`
and `use` SimpleLogger's middleware:

```ruby
# config.ru
# ...
require 'simple_logger/rack'
use SimpleLogger::Rack::Middleware
run MyRackApp.new
```

## Configuration

Configure SimpleLogger any time before your app receives its first request.

For simple Rack applications, this is probably in a `config.ru`, but it
could be in your bootstrap file or elsewhere.
Make sure to `require 'simple_logger'` or `'simple_logger/rack'` before you try to configre it.

```ruby
require 'simple_logger'

SimpleLogger.configure do |c|
  c.http_auth_user = 'my_http_basic_username'
  c.http_auth_password = 'my_http_basic_password'
  c.ignore = lambda do |loggable|
    loggable.type == :request && loggable.value_for(:status) == 301
  end
  c.ignore_paths = /\/(public|admin)/
end
```

### Available Configs

* `http_auth_user` (string): the http basic username for all requests
* `http_auth_password` (string): the http basic password (used only if `http_auth_user` is set)
* `enabled` (bool): you can manually disable SimpleLogger, such as when you're in development or test environments
* `simple_logger_url` (string): set the destination for all your posted logs
* `batch_size` (int): by default, SimpleLogger will queue 5 items before sending them
* `ignore` (lambda): lamba that takes a loggable and returns a boolean indicating whether it should be ignored from logs
* `ignore_paths` (regexp): regular expression for which paths to ignore from request logs

## Usage

Out of the box, for every request, SimpleLogger will send

* REST method
* path
* query (hash)
* status
* remote ip
* user agent
* language

You can add or remove keys by defining them on the `Request` object:

```
SimpleLogger::Request.include_key(:some_other_key)
SimpleLogger::Request.exclude_key(:language)
```
