require 'bundler'
Bundler.require

require File.expand_path('../api/root.rb', __FILE__)

# Swagger UI
use Rack::Static, urls: %w(/docs), index: 'index.html'
run API::Root
