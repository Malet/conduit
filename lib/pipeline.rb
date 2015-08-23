require 'yaml'
require File.expand_path('../pipeline_stage', __FILE__)

class Pipeline
  def self.all
    Dir['pipelines/**/*'].map do |definition|
      next if definition == '.gitignore'
      from_file(definition)
    end.compact
  end

  def self.find(id)
    all.find{ |pipeline| pipeline.id == id }
  end

  def self.from_yaml(id:, yml:)
    new(
      id: id,
      repository_url: (yml['repository']['url'] rescue nil),
      repository_type: (yml['repository']['type'] rescue nil),
      environment: yml['environment'],
      stages: (yml['stages'].map{ |stage| Stage.new(stage) } rescue nil)
    )
  end

  def self.from_file(file)
    from_yaml(
      id:  id_from_file(file),
      yml: YAML.load_file(file)
    )
  end

  PROPERTIES = {
    id:              String,
    repository_url:  String,
    repository_type: String,
    environment:     Hash,
    stages:          Array
  }

  PROPERTIES.each do |k,v|
    attr_reader k.to_sym
  end

  def initialize(options)
    PROPERTIES.each do |k,v|
      type = options[k].class
      unless type == v
        raise StandardError.new(
          "#{k} should be of type #{v} but was #{type}.\n" +
          "options = #{options.inspect}"
        )
      end
      instance_variable_set(:"@#{k}", options[k])
    end
  end

  def as_json
    {
      id: self.id,
      environment: self.environment,
      repository: {
        type: self.repository_type,
        url:  self.repository_url
      },
      stages: self.stages.map(&:as_json)
    }
  end

  private

  def self.id_from_file(file)
    file
      .sub(/^.*?pipelines\//, '') # Remove '*pipelines/'
      .sub(/\..+?$/, '')          # Remove '.yaml'/'.yml'
  end
end
