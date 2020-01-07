require 'spec_helper'

RSpec.describe Abuseipdb::Endpoints::Blacklist do
  before :all do
    Abuseipdb.configure do |config|
      config.timeout = 20
      config.api_key = API_KEY
    end
  end

  let(:params) { { limit: 10, countMinimum: 15, maxAgeInDays: 60 } }

  subject(:blacklist) { Abuseipdb.blacklist }

  context '#call' do
    let(:response) do
      VCR.use_cassette('blacklist', record: :new_episodes) do
        blacklist.call(params)
      end
    end

    it 'status 200' do
      expect(response.status).to be 200
    end

    it 'data exist' do
      expect(response.body).to have_key('data')
    end

    it 'count results' do
      expect(response.body['data'].count).to eq params[:limit]
    end
  end
end
