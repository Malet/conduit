require File.expand_path('../pipelines.rb', __FILE__)

module API
  class Root < Grape::API
    content_type :json, 'application/json'
    default_format :json
    format :json
    prefix :api

    mount API::Pipelines

    add_swagger_documentation(
      hide_documentation_path: true,
      hide_format: true,
      info: {
        title: 'ConduitCI API',
        description: 'API endpoints for the ConduitCI.'
      }
    )
  end
end
