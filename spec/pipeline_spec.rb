require 'minitest/autorun'
require File.expand_path('../../lib/pipeline', __FILE__)

def fixture(name)
  File.expand_path("../fixtures/pipelines/#{name}.yml", __FILE__)
end

describe Pipeline do
  describe 'given a valid pipeline spec' do
    before do
      @pipeline_def = fixture('valid')
    end

    it 'should create the pipeline object' do
      pipeline = Pipeline.from_file(@pipeline_def)
      assert_equal('valid', pipeline.id)
    end
  end

  describe 'given an invalid pipeline spec' do
    describe 'missing stages' do
      before do
        @pipeline_yml = YAML.load(File.read(fixture('valid')))
      end

      %w(repository environment stages).each do |property|
        it "should fail if #{property} is not given" do
          invalid_yml = @pipeline_yml.clone
          invalid_yml.delete(property)
          err = assert_raises(StandardError) do
            Pipeline.from_yaml(
              id: 'invalid',
              yml: invalid_yml
            )
          end
          assert_match(/#{property}[\_[a-z]]*? should be of type [A-Za-z]+ but was NilClass/, err.message)
        end
      end
    end
  end
end
