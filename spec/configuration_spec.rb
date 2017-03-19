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
    context "when enabled flag is set to false in configure" do
      let(:enabled) { false }
      before { SimpleLogger.configure {|c| c.enabled = enabled } }

      it "is disabled" do
        expect(SimpleLogger.config.enabled?).to be false
      end
    end

    context "when default" do
      before { SimpleLogger.instance_variable_set(:@configuration, nil) }

      it "defaults enabled to true" do
        expect(SimpleLogger.config.enabled?).to be true
      end
    end
  end

  context "with http basic" do
    let(:user) { 'username' }
    let(:password) { 'password' }
    before { SimpleLogger.configure {|c| c.http_auth_user = user; c.http_auth_password = password } }

    it "includes the http basic credentials in the URI" do
      expect(SimpleLogger.config.url.userinfo).to eq "#{user}:#{password}"
    end
    
  end
end
