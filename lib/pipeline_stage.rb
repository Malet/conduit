require 'fileutils'

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

    def run
      # Make the directory if it doesn't already exist
      FileUtils.mkdir_p 'cool/beans'

      puts "=== Executing #{self.name} ==="
      self.commands.each do |command|
        puts "- Running \"#{command}\" [#{`#{command}`}]"
      end
    end
  end
end
