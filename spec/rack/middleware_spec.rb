require 'rack/spec_helper.rb'

describe SimpleLogger::Rack do
  let(:headers) { {} }
  let(:status) { 200 }
  let(:body) { ['OK'] }
  let(:app) { lambda {|env| [status, headers, body]} }
  let(:middleware) { SimpleLogger::Rack::Middleware.new(app) }
  let(:request) { Rack::MockRequest.new(middleware) }
  let(:path) { '/' }
  let(:params) { {} }
  let(:get_request) { request.get(path, params) }

  context "requests" do
    it "logs request when request is made" do
      expect_any_instance_of(SimpleLogger::Queue).to receive(:log)
      get_request
    end

    it "queues the request" do
      expect{ get_request }.to change{ middleware.queue.pending.count }
    end

    context "logged data" do
      subject { middleware.queue.pending.last.serialize }

      context "with a request method" do
        it "logs get methods" do
          get_request
          expect(subject[:method]).to eq 'GET'
        end

        it "logs post methods" do
          request.post(path)
          expect(subject[:method]).to eq 'POST'
        end
      end

      context "with a path" do
        let(:path) { '/some_path' }
        before { get_request }

        it "logs the path" do
          expect(subject[:path]).to eq path
        end
      end

      context "with some query params" do
        let(:path) { '/?a=b&c=d' }
        before { get_request }

        it "logs the params" do
          expect(subject[:query]).to eq({ a: 'b', c: 'd' })
        end
      end

      context "with headers" do
        let(:header_value) { 'my header value' }
        let(:header_key) { :MY_CUSTOM_HEADER }
        let(:headers) { { header_key => header_value } }
        before { SimpleLogger::Request.include_key(header_key) }
        after { SimpleLogger::Request.exclude_key(header_key) }

        it "includes the custom header in the log" do
          get_request
          expect(subject[header_key]).to eq header_value
        end
      end
    end
  end
end
