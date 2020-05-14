require 'rails_helper'

RSpec.describe Api::V1::FlightsController, type: :controller do
  describe 'POST#create' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:destination_airport) { Airport.create(
      name: 'SEATTLE TACOMA INTL',
      iata_code: 'SEA',
      latitude: 47.44889,
      longitude: -122.3094,
      city: 'SEATTLE',
      state: 'WA'
      )}
    let!(:departure_airport) { Airport.create(
      name: 'LOGAN',
      iata_code: 'BOS',
      latitude: 122.3094,
      longitude: -47.44889,
      city: 'BOSTON',
      state: 'MA'
      )}
    let!(:destination) { Destination.create(
      name: 'Seattle',
      state: 'Washington',
      address: '123 Main St',
      latitude: 12.3456789,
      longitude: -98.7654321,
      airport: destination_airport
      ) }
    let!(:listing) { Listing.create(destination: destination, user: user) }
    let!(:params_hash) { {
      airport_code: 'BOS',
      departure_date: '2020-08-01',
      return_date: '2020-08-05',
    } }

    it "creates a flight record for each unique airport in current user's listings" do
      sign_in user
      previous_count = Flight.count
      post :create, params: params_hash
      new_count = Flight.count

      expect(new_count).to eq (previous_count + 1)
    end

    it 'returns json for the suggested flight' do
      sign_in user
      post :create, params: params_hash
      parsed_response = JSON.parse(response.body)
      result = parsed_response['flight']

      expect(result).to be_kind_of(Hash)
      expect(result.length).to eq 4
      expect(result).to have_key 'departure_airport'
      expect(result).to have_key 'destination_airport'
      expect(result).to have_key 'destinations'
      expect(result['departure_airport']['id']).to eq departure_airport.id
      expect(result['departure_airport']['name']).to eq departure_airport.name
      expect(result['departure_airport']['iata_code']).to eq departure_airport.iata_code
      expect(result['departure_airport']['city']).to eq departure_airport.city
      expect(result['destination_airport']['id']).to eq destination_airport.id
      expect(result['destination_airport']['name']).to eq destination_airport.name
      expect(result['destination_airport']['iata_code']).to eq destination_airport.iata_code
      expect(result['destination_airport']['city']).to eq destination_airport.city
      expect(result['destinations']).to be_kind_of(Array)
      expect(result['destinations'][0]['id']).to eq destination.id
      expect(result['destinations'][0]['name']).to eq destination.name
      expect(result['destinations'][0]['state']).to eq destination.state
    end
  end

  describe 'GET#index' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:destination_airport) { Airport.create(
      name: 'SEATTLE TACOMA INTL',
      iata_code: 'SEA',
      latitude: 47.44889,
      longitude: -122.3094,
      city: 'SEATTLE',
      state: 'WA'
      )}
    let!(:departure_airport) { Airport.create(
      name: 'LOGAN',
      iata_code: 'BOS',
      latitude: 122.3094,
      longitude: -47.44889,
      city: 'BOSTON',
      state: 'MA'
      )}
    let!(:destination) { Destination.create(
      name: 'Seattle',
      state: 'Washington',
      address: '123 Main St',
      latitude: 12.3456789,
      longitude: -98.7654321,
      airport: destination_airport
      ) }
    let!(:listing) { Listing.create(destination: destination, user: user) }

    context 'when there are recommended flights for the current user' do
      let!(:flight1) { Flight.create(
        departure_iata: 'BOS',
        destination_iata: 'SEA',
        departure_date: '2020-08-01',
        return_date: '2020-08-01',
        average_price: 280.55,
        recommended: true,
        user: user
        )}
      let!(:flight2) { Flight.create(
        departure_iata: 'BOS',
        destination_iata: 'SEA',
        departure_date: '2020-08-01',
        return_date: '2020-08-01',
        average_price: 280.55,
        recommended: true,
        user: user
        )}

      it 'returns json of the most recent recommended flight' do
        sign_in user
        get :index
        parsed_response = JSON.parse(response.body)
        result = parsed_response['flight']

        expect(result).to be_kind_of(Hash)
        expect(result['id']).to eq flight2.id
        expect(result['departure_airport']['id']).to eq departure_airport.id
        expect(result['departure_airport']['name']).to eq departure_airport.name
        expect(result['departure_airport']['iata_code']).to eq departure_airport.iata_code
        expect(result['departure_airport']['city']).to eq departure_airport.city
        expect(result['destination_airport']['id']).to eq destination_airport.id
        expect(result['destination_airport']['name']).to eq destination_airport.name
        expect(result['destination_airport']['iata_code']).to eq destination_airport.iata_code
        expect(result['destination_airport']['city']).to eq destination_airport.city
        expect(result['destinations']).to be_kind_of(Array)
        expect(result['destinations'][0]['id']).to eq destination.id
        expect(result['destinations'][0]['name']).to eq destination.name
        expect(result['destinations'][0]['state']).to eq destination.state
      end

      it 'does not return json of older recommended flights' do
        sign_in user
        get :index
        parsed_response = JSON.parse(response.body)
        result = parsed_response['flight']

        expect(result).to be_kind_of(Hash)
        expect(result['id']).to_not eq flight1.id
      end
    end

    context 'when there are no recommended flights for the current user' do
      it 'returns json of an empty hash' do
        sign_in user
        get :index
        parsed_response = JSON.parse(response.body)
        result = parsed_response['flight']

        expect(result).to be_empty
      end
    end
  end
end
