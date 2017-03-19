require 'spec_helper'

describe SimpleLogger::Configuration do

  context "with defaults" do
    it "sets the batch size" do
      expect(SimpleLogger.config.batch_size).to be_a Integer
    end
  end

  context "with configured values" do
    let(:new_batch_size) { 7 }
    before do
      SimpleLogger.configure do |c|
        c.batch_size = new_batch_size
      end
    end

    it "uses the new batch size" do
      expect(SimpleLogger.config.batch_size).to eq new_batch_size
    end
  end

  context "#enabled?" do
    context "with keys" do
      let(:key) { 'some key' }
      before { SimpleLogger.configure {|c| c.key = key } }

      context "without a key" do
        let(:key) { nil }

        it "is not enabled" do
          expect(SimpleLogger.config.enabled?).to be false
        end

        context "even if manually enabled" do
          before { SimpleLogger.configure {|c| c.enabled = true } }

          it "is not enabled" do
            expect(SimpleLogger.config.enabled?).to be false
          end
        end
      end

      context "with a key" do
        it "is enabled by default" do
          expect(SimpleLogger.config.enabled?).to be true
        end
      end
    end

    context "when manually disabled" do
      let(:enabled) { false }
      let(:key) { 'something' }
      before { SimpleLogger.configure {|c| c.enabled = enabled; c.key = key } }

      it "is disabled" do
        expect(SimpleLogger.config.enabled?).to be false
      end

      it "doesn't send any batched data" do
        batch = SimpleLogger::Batch.new(key: 'value')
        expect(batch.deliver(async: false)).to be_nil
      end
    end
  end
end
