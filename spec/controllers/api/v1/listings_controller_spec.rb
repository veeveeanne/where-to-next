require 'rails_helper'
require 'active_support'

RSpec.describe Api::V1::ListingsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:destination) { Destination.create(
    name: 'Boston',
    state: 'Massachusetts',
    address: '123 Main St',
    latitude: 12.3456789,
    longitude: -98.7654321
    ) }

  describe 'POST#create' do
    it 'creates a new listing' do
      sign_in user
      previous_count = Listing.count
      post :create, params: { id: destination.id }
      new_count = Listing.count

      expect(new_count).to eq(previous_count + 1)
    end

    it 'returns json of destination for the new listing' do
      sign_in user
      post :create, params: { id: destination.id }
      parsed_response = JSON.parse(response.body)
      result = parsed_response['listing']

      expect(result).to be_kind_of(Hash)
      expect(result.length).to eq 3
      expect(result['visited']).to eq false
      expect(result['destination']['id']).to eq destination.id
      expect(result['destination']['name']).to eq destination.name
      expect(result['destination']['state']).to eq destination.state
      expect(result['destination']['address']).to eq destination.address
      expect(result['destination']['latitude'].to_d).to eq destination.latitude
      expect(result['destination']['longitude'].to_d).to eq destination.longitude
    end
  end

  describe 'GET#index' do
    let!(:listing) { Listing.create(destination: destination, user: user) }

    it 'returns the listing of destinations a user has added to their list' do
      sign_in user
      get :index
      parsed_response = JSON.parse(response.body)
      results = parsed_response['listings']

      expect(results).to be_kind_of(Array)
      expect(results.length).to eq 1
      expect(results[0]['id']).to eq listing.id
      expect(results[0]['visited']).to eq false
      expect(results[0]).to have_key 'destination'
      expect(results[0]['destination']['id']).to eq destination.id
      expect(results[0]['destination']['name']).to eq destination.name
      expect(results[0]['destination']['state']).to eq destination.state
      expect(results[0]['destination']['address']).to eq destination.address
      expect(results[0]['destination']['latitude'].to_d).to eq destination.latitude
      expect(results[0]['destination']['longitude'].to_d).to eq destination.longitude
    end

    it 'does not return destinations that the user has not added to their list' do
      new_user = FactoryBot.create(:user)
      new_destination = Destination.create(
        name: 'Seattle',
        state: 'Washington',
        address: '321 Main St',
        latitude: 34.1256789,
        longitude: -76.9854321
        )
      new_listing = Listing.create(destination: new_destination, user: new_user)

      sign_in new_user
      get :index
      parsed_response = JSON.parse(response.body)
      results = parsed_response['listings']

      expect(results[0]['destination']['id']).to_not eq destination.id
      expect(results[0]['destination']['name']).to_not eq destination.name
      expect(results[0]['destination']['state']).to_not eq destination.state
      expect(results[0]['destination']['address']).to_not eq destination.address
      expect(results[0]['destination']['latitude'].to_d).to_not eq destination.latitude
      expect(results[0]['destination']['longitude'].to_d).to_not eq destination.longitude
    end
  end

  describe 'GET#show' do
    let!(:listing) { Listing.create(destination: destination, user: user) }

    it "returns json for the listing with 'id' provided in params" do
      get :show, params: {id: listing.id}
      parsed_response = JSON.parse(response.body)
      result = parsed_response['listing']

      expect(result).to be_kind_of(Hash)
      expect(result.length).to eq 3
      expect(result['id']).to eq listing.id
      expect(result['destination']['name']).to eq destination.name
      expect(result['destination']['state']).to eq destination.state
      expect(result['destination']['address']).to eq destination.address
      expect(result['destination']['latitude'].to_d).to eq destination.latitude
      expect(result['destination']['longitude'].to_d).to eq destination.longitude
    end
  end

  describe 'PATCH#update' do
    let!(:listing) { Listing.create(destination: destination, user: user) }

    it "changes the boolean value for 'visited' for the specified listing" do
      sign_in user
      previous_visited_value = listing.visited
      patch :update, params: {id: listing.id, visited: true}
      new_visited_value = Listing.find(listing.id).visited

      expect(new_visited_value).to_not eq previous_visited_value
      expect(new_visited_value).to eq true
    end

    it 'returns the json for the updated listing' do
      sign_in user
      patch :update, params: { id: listing.id, visited: true }
      parsed_response = JSON.parse(response.body)
      result = parsed_response['listing']

      expect(result['id']).to eq listing.id
      expect(result['destination']['id']).to eq listing.destination_id
      expect(result['visited']).to eq true
    end
  end

  describe 'DELETE#destroy' do
    let!(:listing) { Listing.create(destination: destination, user: user) }

    it 'removes the specified listing from the database' do
      sign_in user
      previous_count = Listing.count
      delete :destroy, params: { id: listing.id }
      new_count = Listing.count

      expect(new_count).to eq (previous_count - 1)
    end

    it 'returns the updated list of listings for the current user' do
      new_destination = Destination.create(
        name: 'Seattle',
        state: 'Washington',
        address: '321 Main St',
        latitude: 34.1256789,
        longitude: -76.9854321
        )
      new_listing = Listing.create(destination: new_destination, user: user)

      sign_in user
      delete :destroy, params: { id: listing.id }
      parsed_response = JSON.parse(response.body)
      results = parsed_response['listings']

      expect(results).to be_kind_of(Array)
      expect(results.length).to eq 1
      expect(results[0]['id']).to eq new_listing.id
      expect(results[0]['destination']['id']).to eq new_listing.destination_id
    end
  end

  describe 'GET#search' do
    it 'returns json with destinations in the database which match the given params' do
      get :search, params: { name: 'boston', state: 'Massachusetts' }
      parsed_response = JSON.parse(response.body)
      results = parsed_response['destinations']

      expect(results).to be_kind_of(Array)
      expect(results.length).to eq 1
      expect(results[0]['id']).to eq destination.id
      expect(results[0]['name']).to eq destination.name
      expect(results[0]['state']).to eq destination.state
      expect(results[0]['address']).to eq destination.address
      expect(results[0]['latitude'].to_d).to eq destination.latitude
      expect(results[0]['longitude'].to_d).to eq destination.longitude
    end
  end
end
