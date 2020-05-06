require 'rails_helper'
require 'active_support'

RSpec.describe Api::V1::ListingsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:destination) { Destination.create(
    name: "Boston",
    state: "Massachusetts",
    address: "123 Main St",
    latitude: 12.3456789,
    longitude: -98.7654321
    ) }

  describe "POST#create" do
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

  describe "GET#index" do
    let!(:listing) { Listing.create(destination: destination, user: user) }

    it "returns the list of destinations that a user has added to their list" do
      sign_in user
      get :index
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

    it "does not return destinations that the user has not added to their list" do
      new_user = FactoryBot.create(:user)
      new_destination = Destination.create(
        name: "Seattle",
        state: "Washington",
        address: "321 Main St",
        latitude: 34.1256789,
        longitude: -76.9854321
        )
      new_listing = Listing.create(destination: new_destination, user: new_user)

      sign_in new_user
      get :index
      returned_json = JSON.parse(response.body)
      results = returned_json["destinations"]

      expect(results[0]["id"]).to_not eq destination.id
      expect(results[0]["name"]).to_not eq destination.name
      expect(results[0]["state"]).to_not eq destination.state
      expect(results[0]["address"]).to_not eq destination.address
      expect(results[0]["latitude"].to_d).to_not eq destination.latitude
      expect(results[0]["longitude"].to_d).to_not eq destination.longitude
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
