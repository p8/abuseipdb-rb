require 'spec_helper'

RSpec.describe Abuseipdb::Endpoints::Report do
  before :all do
    Abuseipdb.configure do |config|
      config.timeout = 20
      config.api_key = API_KEY
    end
  end

  let(:params) { { ip: '127.0.0.2', categories: [22] } }

  subject(:report) { Abuseipdb.report }

  context '#call' do
    let(:response) do
      VCR.use_cassette('report', record: :new_episodes) do
        report.call(params)
      end
    end

    it 'status 200' do
      expect(response.status).to be 200
    end

    it 'data exist' do
      expect(response.body).to have_key('data')
    end

    it 'correct ipAddress' do
      expect(response.body['data']['ipAddress']).to eq params[:ip]
    end
  end
end
