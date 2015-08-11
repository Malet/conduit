class Pipeline
  def self.all
    Dir['pipelines/**/*'].map do |definition|
      next if definition == '.gitkeep'

      {
        id: definition
          .sub(/^.+?\//, '')  # Remove 'pipelines/'
          .sub(/\..+?$/, ''), # Remove '.yaml'/'.yml'
        spec: YAML.load(File.read(definition))
      }
    end.compact
  end
end
