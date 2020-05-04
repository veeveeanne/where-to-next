require 'rails_helper'

RSpec.describe Api::V1::DestinationsController, type: :controller do
  let!(:first_destination) { Destination.create(
    name: "Boston",
    state: "Massachusetts",
    address: "123 Main St",
    latitude: 12.3456789,
    longitude: -98.7654321
  ) }
  let!(:second_destination) { Destination.create(
    name: "Seattle",
    state: "Washington",
    address: "123 Main St",
    latitude: 12.3456789,
    longitude: -98.7654321
  ) }

  describe "GET#index" do
    it "should return a list of all the destinations" do
      get :index
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
      expect(returned_json.length).to eq 1
      expect(returned_json["destinations"].length).to eq 2
      expect(returned_json["destinations"][0]["name"]).to eq "Boston"
      expect(returned_json["destinations"][0]["state"]).to eq "Massachusetts"
      expect(returned_json["destinations"][0]["address"]).to eq "123 Main St"
      expect(returned_json["destinations"][0]["latitude"]).to eq "12.3456789"
      expect(returned_json["destinations"][0]["longitude"]).to eq "-98.7654321"
      expect(returned_json["destinations"][1]["name"]).to eq "Seattle"
      expect(returned_json["destinations"][1]["state"]).to eq "Washington"
      expect(returned_json["destinations"][1]["address"]).to eq "123 Main St"
      expect(returned_json["destinations"][1]["latitude"]).to eq "12.3456789"
      expect(returned_json["destinations"][1]["longitude"]).to eq "-98.7654321"
    end
  end

  describe "GET#search" do
    let(:cassette) {VCR.use_cassette("get_location") {
      query_string = "Museum of Modern Art New York".gsub(" ", "%20")
      url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{query_string}&key=#{ENV["PLACES_API_KEY"]}"
      api_response = Faraday.get(url)
      response_body = JSON.parse(api_response.body)
      } }

    it "returns a successful response status from the external API" do
      VCR.use_cassette("get_location") do
        expect(response.status).to eq 200
      end
    end

    it "returns search results from the external API based on the query string" do
      results = cassette["results"]

      expect(results.length).to eq 1
      expect(results[0]["name"]).to include "Museum of Modern Art"
      expect(results[0]["formatted_address"]).to include "New York"
    end
  end
end
