require 'bundler'
Bundler.require

require File.expand_path('../api/api.rb', __FILE__)
run API

# Swagger UI
use Rack::Static, urls: %w(/docs), index: 'index.html'
