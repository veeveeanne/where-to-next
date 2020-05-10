require 'rails_helper'

RSpec.describe Api::V1::FlightsController, type: :controller do
  describe 'POST#create' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:airport) { Airport.create(
      name: 'SEATTLE TACOMA INTL',
      iata_code: 'SEA',
      latitude: 47.44889,
      longitude: -122.3094,
      city: 'SEATTLE'
      )}
    let!(:destination) { Destination.create(
      name: 'Seattle',
      state: 'Washington',
      address: '123 Main St',
      latitude: 12.3456789,
      longitude: -98.7654321,
      airport: airport
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

    it "returns json for the airport of the suggested destination" do
      sign_in user
      post :create, params: params_hash
      parsed_response = JSON.parse(response.body)
      suggested_destination = Flight.find_by(recommended: true)

      expect(parsed_response['iata_code']).to eq suggested_destination.destination_iata
    end
  end
end
