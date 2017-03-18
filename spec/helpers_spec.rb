require 'spec_helper.rb'

describe SimpleLogger::Helpers do
  context "#symobolize_keys" do
    let(:hash) { { "a" => 1 } }
    subject { SimpleLogger::Helpers.symbolize_keys(hash) }

    it "symbolizes the key" do
      subject.keys.each do |k|
        expect(k).to be_a Symbol
      end
    end
  end
end
