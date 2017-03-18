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
end
