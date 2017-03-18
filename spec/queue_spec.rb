require 'spec_helper'

describe SimpleLogger::Queue do
  context "when the queue exceeds the batch size" do
    let(:batch_size) { 2 }
    before { SimpleLogger.configure {|c| c.batch_size = 2 } }
    let(:request) { SimpleLogger::Request.new({}) }
    let(:requests) { Array.new(batch_size) {|i| request} }
    let(:queue) { SimpleLogger::Queue.new }

    it "purges the queue" do
      expect(queue).to receive(:deliver!)
      requests.each do |request|
        queue.log(request)
      end
    end

    it "never has more than the batch size" do
      (batch_size * 2).times do
        queue.log(request)
        expect(queue.count <= batch_size).to be true
      end
    end
  end
end
