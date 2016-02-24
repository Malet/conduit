require 'bundler'
Bundler.require

WORKSPACE_DIR = ENV['WORKSPACE_DIR'] || 'workspace'

# Connect to redis on REDIS_URL
Redis.current = Redis.new

require File.expand_path('../api/root', __FILE__)

# Swagger UI
use Rack::Static, urls: %w(/docs), index: 'index.html'
run API::Root
