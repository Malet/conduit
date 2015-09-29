require 'minitest/autorun'
require File.expand_path('../../lib/pipeline_queue', __FILE__)

describe PipelineQueue do
  before{ PipelineQueue.reset }

  it 'initialises each queue to be an empty VisibleQueue' do
    %w(awaiting processing completed).each do |stage|
      assert(PipelineQueue.send(stage).class <= VisibleQueue)
      assert_equal(0, PipelineQueue.send(stage).size)
    end
  end

  describe 'scheduling a pipeline' do
    before{ @item = "Pipeline #{rand(0..999)}" }

    it 'proceeds through the queues' do
      PipelineQueue.awaiting.enq(@item)
      assert_equal([@item], PipelineQueue.awaiting)
      assert_equal([], PipelineQueue.processing)
      assert_equal([], PipelineQueue.completed)

      PipelineQueue.awaiting.deq
      assert_equal([], PipelineQueue.awaiting)
      assert_equal([@item], PipelineQueue.processing)
      assert_equal([], PipelineQueue.completed)

      PipelineQueue.processing.deq
      assert_equal([], PipelineQueue.awaiting)
      assert_equal([], PipelineQueue.processing)
      assert_equal([@item], PipelineQueue.completed)
    end
  end
end
