require 'rails_helper'
require 'active_support'

RSpec.describe Api::V1::DestinationsController, type: :controller do
  let!(:first_destination) { Destination.create(
    name: 'Boston',
    state: 'Massachusetts',
    address: '123 Main St',
    latitude: 12.3456789,
    longitude: -98.7654321
  ) }
  let!(:second_destination) { Destination.create(
    name: 'Seattle',
    state: 'Washington',
    address: '123 Main St',
    latitude: 12.3456789,
    longitude: -98.7654321
  ) }

  describe 'GET#index' do
    it 'should return a list of all the destinations' do
      get :index
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/json'
      expect(parsed_response.length).to eq 1
      expect(parsed_response['destinations'].length).to eq 2
      expect(parsed_response['destinations'][0]['name']).to eq first_destination.name
      expect(parsed_response['destinations'][0]['state']).to eq first_destination.state
      expect(parsed_response['destinations'][0]['address']).to eq first_destination.address
      expect(parsed_response['destinations'][0]['latitude'].to_d).to eq first_destination.latitude
      expect(parsed_response['destinations'][0]['longitude'].to_d).to eq first_destination.longitude
      expect(parsed_response['destinations'][1]['name']).to eq second_destination.name
      expect(parsed_response['destinations'][1]['state']).to eq second_destination.state
      expect(parsed_response['destinations'][1]['address']).to eq second_destination.address
      expect(parsed_response['destinations'][1]['latitude'].to_d).to eq second_destination.latitude
      expect(parsed_response['destinations'][1]['longitude'].to_d).to eq second_destination.longitude
    end
  end

  describe 'POST#create' do
    let!(:existing_params) { {
      name: 'Boston',
      state: 'Massachusetts',
      address: '123 Main St',
      latitude: 12.3456789,
      longitude: -98.7654321
    } }
    let!(:new_params) { {
      name: 'Chicago',
      state: 'Illinois',
      address: '123 Main St',
      latitude: 34.1256789,
      longitude: -76.9854321
    } }

    context 'when a record already exists in the database for the given params' do
      it 'does not create a new record' do
        previous_count = Destination.count
        post :create, params: existing_params
        new_count = Destination.count

        expect(new_count).to eq previous_count
      end

      it 'finds and return json for the record with the given params' do
        post :create, params: existing_params
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 1
        expect(parsed_response['destination'].length).to eq 7
        expect(parsed_response['destination']['id']).to eq first_destination.id
        expect(parsed_response['destination']['name']).to eq first_destination.name
        expect(parsed_response['destination']['state']).to eq first_destination.state
        expect(parsed_response['destination']['address']).to eq first_destination.address
        expect(parsed_response['destination']['latitude'].to_d).to eq first_destination.latitude
        expect(parsed_response['destination']['longitude'].to_d).to eq first_destination.longitude
      end
    end

    context 'when there are no records in the database for the given params' do
      it 'creates a new record' do
        previous_count = Destination.count
        post :create, params: new_params
        new_count = Destination.count

        expect(new_count).to eq (previous_count + 1)
      end

      it 'returns json for the new record created with the given params' do
        post :create, params: new_params
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.length).to eq 1
        expect(parsed_response['destination'].length).to eq 7
        expect(parsed_response['destination']['name']).to eq new_params[:name]
        expect(parsed_response['destination']['state']).to eq new_params[:state]
        expect(parsed_response['destination']['address']).to eq new_params[:address]
        expect(parsed_response['destination']['latitude'].to_d).to eq new_params[:latitude].to_d
        expect(parsed_response['destination']['longitude'].to_d).to eq new_params[:longitude].to_d
      end
    end
  end

  describe 'GET#search' do
    it 'makes a request to the external API based on the params' do
      VCR.use_cassette('get_location') do
        get :search, params: {query: 'Museum of Modern Art New York'}
        parsed_response = JSON.parse(response.body)
        results = parsed_response['results']

        expect(results.length).to eq 1
        expect(results[0]).to have_key 'name'
        expect(results[0]).to have_key 'formatted_address'
        expect(results[0]).to have_key 'geometry'
        expect(results[0]['geometry']).to have_key 'location'
        expect(results[0]['geometry']['location']).to have_key 'lat'
        expect(results[0]['geometry']['location']).to have_key 'lng'
        expect(results[0]['name']).to include 'Museum of Modern Art'
        expect(results[0]['formatted_address']).to include 'New York'
      end
    end
  end
end
