require File.expand_path('../../lib/pipeline', __FILE__)

module API
  class Pipelines < Grape::API
    resource :pipelines do
      desc 'Get all pipelines'
      get do
        Pipeline.all.map(&:as_json)
      end

      desc 'Get pipeline by id'
      params do
        requires :id, type: String, desc: "Pipeline ID (including namespace)"
      end
      get ':id' do
        pipeline = Pipeline.find(params[:id]) ?
          pipeline.as_json :
          error!("Pipeline not found with id: #{params[:id]}", 404)
      end
    end
  end
end
