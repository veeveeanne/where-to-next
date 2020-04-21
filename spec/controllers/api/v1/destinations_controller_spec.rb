require 'rails_helper'

RSpec.describe Api::V1::DestinationsController, type: :controller do
  let!(:first_destination) { Destination.create(
    name: "Boston",
    state: "Massachusetts"
  ) }
  let!(:second_destination) { Destination.create(
    name: "Seattle",
    state: "Washington"
  ) }

  describe "GET#index" do
    it "should return a list of all the destinations" do
      get :index
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
      expect(returned_json.length).to eq 2
      expect(returned_json[0]["name"]).to eq "Boston"
      expect(returned_json[0]["state"]).to eq "Massachusetts"
      expect(returned_json[1]["name"]).to eq "Seattle"
      expect(returned_json[1]["state"]).to eq "Washington"
    end
  end
end
