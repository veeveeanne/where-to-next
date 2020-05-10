require 'rails_helper'

describe AmadeusWrapper do
  describe '.fetch_airport' do
    it 'returns json of the first airport from the query results' do
      response = AmadeusWrapper.fetch_airport(42.361145, -71.057083)

      expect(response).to be_kind_of(Hash)
      expect(response.length).to eq 5
      expect(response).to have_key(:name)
      expect(response).to have_key(:iata_code)
      expect(response).to have_key(:city)
      expect(response).to have_key(:latitude)
      expect(response).to have_key(:longitude)
      expect(response[:name]).to eq 'EDWARD L LOGAN INTL'
      expect(response[:iata_code]).to eq 'BOS'
      expect(response[:city]).to eq 'BOSTON'
      expect(response[:latitude]).to eq 42.36514
      expect(response[:longitude]).to eq -71.01777
    end
  end

  describe '.fetch_airports' do
    it 'returns json of the airport matches based on the query' do
      response = AmadeusWrapper.fetch_airports('boston')

      expect(response).to be_kind_of(Array)
      expect(response.length).to eq 1
      expect(response[0]).to have_key(:name)
      expect(response[0]).to have_key(:iata_code)
      expect(response[0]).to have_key(:city)
      expect(response[0]).to have_key(:latitude)
      expect(response[0]).to have_key(:longitude)
      expect(response[0][:name]).to eq 'EDWARD L LOGAN INTL'
      expect(response[0][:iata_code]).to eq 'BOS'
      expect(response[0][:city]).to eq 'BOSTON'
      expect(response[0][:latitude]).to eq 42.36514
      expect(response[0][:longitude]).to eq -71.01777
    end
  end

  describe '.fetch_flights' do
    it 'returns json of the desination airport and its flight prices' do
      response = AmadeusWrapper.fetch_flights(
        origin: 'BOS',
        destination: 'SEA',
        departureDate: '2020-08-01',
        returnDate: '2020-08-05'
      )

      expect(response).to be_kind_of(Hash)
      expect(response).to have_key('SEA')
      expect(response['SEA']).to be_kind_of(Array)
      expect(response['SEA'].first).to be_kind_of(Float)
      expect(response['SEA'].last).to be_kind_of(Float)
    end
  end
end
