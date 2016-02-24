class Pipeline
  class Stage
    attr_reader :name
    attr_reader :commands

    def initialize(options)
      @name     = options['name']
      @commands = options['commands']
      @pipeline = options['pipeline']
    end

    def as_json
      {
        name:     self.name,
        commands: self.commands,
      }
    end
  end
end
