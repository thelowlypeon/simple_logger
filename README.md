# Simple Logger (for Rack applications)

Asynchronously send request logs and errors to Simple Logger for your Rack app.

## Installation

Add the following to your Rack application's `Gemfile`:

```
# Gemfile
gem 'simple_logger', git: 'https://github.com/thelowlypeon/simple_logger'
```

If you're running your application with a `config.ru`, simply require `simple_logger/rack`
and `use` SimpleLogger's middleware:

```
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

```
require 'simple_logger'

SimpleLogger.configure do |c|
  c.http_auth_user = 'my_http_basic_username'
  c.http_auth_password = 'my_http_basic_password'
end
```

### Available Configs

* `http_auth_user` (string): the http basic username for all requests
* `http_auth_password` (string): the http basic password (used only if `http_auth_user` is set)
* `enabled` (bool): you can manually disable SimpleLogger, such as when you're in development or test environments
* `simple_logger_url` (string): set the destination for all your posted logs
* `batch_size` (int): by default, SimpleLogger will queue 5 items before sending them
