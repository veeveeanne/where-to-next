require 'rails_helper'
require 'active_support'

RSpec.describe Api::V1::ListingsController, type: :controller do
  let!(:destination) { Destination.create(
    name: "Boston",
    state: "Massachusetts",
    address: "123 Main St",
    latitude: 12.3456789,
    longitude: -98.7654321
    ) }

  describe "POST#create" do
    let!(:user) { FactoryBot.create(:user) }

    it "creates a new listing" do
      sign_in user
      previous_count = Listing.count
      post :create, params: { id: destination.id }
      new_count = Listing.count

      expect(new_count).to eq(previous_count + 1)
    end

    it "returns json with the new listing" do
      sign_in user
      post :create, params: { id: destination.id }
      returned_json = JSON.parse(response.body)

      expect(returned_json).to be_kind_of(Hash)
      expect(returned_json.length).to eq 5
      expect(returned_json["destination_id"]).to eq destination.id
      expect(returned_json["user_id"]).to eq user.id
    end
  end

  describe "GET#search" do
    it "returns json with destinations in the database which match the given params" do
      get :search, params: { name: "boston", state: "Massachusetts" }
      returned_json = JSON.parse(response.body)
      results = returned_json["destinations"]

      expect(results).to be_kind_of(Array)
      expect(results.length).to eq 1
      expect(results[0]["id"]).to eq destination.id
      expect(results[0]["name"]).to eq destination.name
      expect(results[0]["state"]).to eq destination.state
      expect(results[0]["address"]).to eq destination.address
      expect(results[0]["latitude"].to_d).to eq destination.latitude
      expect(results[0]["longitude"].to_d).to eq destination.longitude
    end
  end
end
