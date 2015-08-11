require File.expand_path('../../lib/pipeline', __FILE__)

module API
  class Pipelines < Grape::API
    resource :pipelines do
      desc 'Get all pipelines'
      get do
        Pipeline.all
      end

      desc 'Get pipeline by id'
      params do
        requires :id, type: String, desc: "Pipeline ID (including namespace)"
      end
      get ':id' do
        Pipeline.all.find do |pipeline|
          pipeline[:id] == params[:id]
        end
      end
    end
  end
end
