require File.expand_path('../../lib/pipeline', __FILE__)

module API
  class Pipelines < Grape::API
    resource :pipelines do
      desc 'Get all pipelines'
      get do
        Pipeline.all
      end
    end
  end
end
