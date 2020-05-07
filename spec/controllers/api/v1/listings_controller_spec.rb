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

    it "returns json of destination for the new listing" do
      sign_in user
      post :create, params: { id: destination.id }
      returned_json = JSON.parse(response.body)
      result = returned_json["destination"]

      expect(result).to be_kind_of(Hash)
      expect(result.length).to eq 7
      expect(result["id"]).to eq destination.id
      expect(result["name"]).to eq destination.name
      expect(result["state"]).to eq destination.state
      expect(result["address"]).to eq destination.address
      expect(result["latitude"].to_d).to eq destination.latitude
      expect(result["longitude"].to_d).to eq destination.longitude
      expect(result["user_listing"]["destination_id"]).to eq destination.id
      expect(result["user_listing"]["user_id"]).to eq user.id
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
      expect(results[0]["user_listing"]["id"]).to eq listing.id
      expect(results[0]["user_listing"]["destination_id"]).to eq destination.id
      expect(results[0]["user_listing"]["user_id"]).to eq user.id
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
      expect(results[0]["user_listing"]["id"]).to_not eq listing.id
      expect(results[0]["user_listing"]["destination_id"]).to_not eq destination.id
      expect(results[0]["user_listing"]["user_id"]).to_not eq user.id
    end
  end

  describe "PATCH#update" do
    let!(:listing) { Listing.create(destination: destination, user: user) }

    it "changes the boolean value for 'visited' for the specified listing" do
      sign_in user
      previous_visited_value = listing.visited
      patch :update, params: {id: listing.id, visited: true}
      new_visited_value = Listing.find(listing.id).visited

      expect(new_visited_value).to_not eq previous_visited_value
      expect(new_visited_value).to eq true
    end

    it "returns the json for the updated listing" do
      sign_in user
      patch :update, params: { id: listing.id, visited: true }
      returned_json = JSON.parse(response.body)

      expect(returned_json["id"]).to eq listing.id
      expect(returned_json["destination_id"]).to eq listing.destination_id
      expect(returned_json["user_id"]).to eq listing.user_id
      expect(returned_json["visited"]).to eq true
    end
  end

  describe "DELETE#destroy" do
    let!(:listing) { Listing.create(destination: destination, user: user) }

    it "removes the specified listing from the database" do
      sign_in user
      previous_count = Listing.count
      delete :destroy, params: { id: listing.id }
      new_count = Listing.count

      expect(new_count).to eq (previous_count - 1)
    end

    it "returns the updated list of listings for the current user" do
      new_destination = Destination.create(
        name: "Seattle",
        state: "Washington",
        address: "321 Main St",
        latitude: 34.1256789,
        longitude: -76.9854321
        )
      new_listing = Listing.create(destination: new_destination, user: user)

      sign_in user
      delete :destroy, params: { id: listing.id }
      returned_json = JSON.parse(response.body)

      expect(returned_json).to be_kind_of(Array)
      expect(returned_json.length).to eq 1
      expect(returned_json[0]["id"]).to eq new_listing.id
      expect(returned_json[0]["destination_id"]).to eq new_listing.destination_id
      expect(returned_json[0]["user_id"]).to eq new_listing.user_id
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
