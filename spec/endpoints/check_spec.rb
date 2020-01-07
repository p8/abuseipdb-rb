require 'spec_helper'

RSpec.describe Abuseipdb::Endpoints::Check do
  before :all do
    Abuseipdb.configure do |config|
      config.timeout = 20
      config.api_key = API_KEY
    end
  end

  let(:params) { { ipAddress: "8.8.8.8" } }

  subject(:check) { Abuseipdb.check }

  context '#call' do
    let(:response) do
      VCR.use_cassette('check', record: :new_episodes) do
        check.call(params)
      end
    end

    it 'status 200' do
      expect(response.status).to be 200
    end

    it 'data exist' do
      expect(response.body).to have_key('data')
    end

    it 'correct ipAddress' do
      expect(response.body['data']['ipAddress']).to eq params[:ipAddress]
    end
  end
end
