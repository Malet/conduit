module API
  class Pipelines < Grape::API
    resource :pipelines do
      desc 'Get all pipelines'
      get do
        [
          {
            name: 'test',
            runs: 4
          }
        ]
      end
    end
  end
end
