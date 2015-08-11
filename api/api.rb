class API < Grape::API
  # version 'v1', using: :header, vendor: 'twitter'
  format :json
  prefix :api

  resource :pipelines do
    desc 'Get all pipelines'
    get do
      "pipelines"
    end
  end
end
