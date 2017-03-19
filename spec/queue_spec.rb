require 'spec_helper'

describe SimpleLogger::Queue do
  context "when the queue exceeds the batch size" do
    let(:batch_size) { 20 }
    before { SimpleLogger.configure {|c| c.batch_size = batch_size } }
    let(:request) { SimpleLogger::Request.new({}) }
    let(:requests) { Array.new(batch_size + 1) {|i| request} }
    let(:queue) { SimpleLogger::Queue.new }
    before { SimpleLogger.configure{|c| c.enabled = false } }

    it "purges the queue" do
      expect_any_instance_of(SimpleLogger::Batch).to receive(:deliver)
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

    context "when delivering synchronously because it's harder to test async" do
      before { SimpleLogger.configure{|c| c.deliver_async = false; c.enabled = true } }

      it "delivers the data" do
        expect(Net::HTTP).to receive(:post_form)
        requests.each do |request|
          queue.log(request)
        end
      end
    end
  end
end
