require 'rails_helper'

RSpec.describe Api::V1::AirportsController, type: :controller do
  describe "POST#create" do
    let!(:destination) { Destination.create(
      name: "Boston",
      state: "Massachusetts",
      address: "123 Main St",
      latitude: 42.361145,
      longitude: -71.057083
      ) }

    it "creates a new airport record and associates it with the specified destination" do
      post :create, params: { destination: {
        id: destination.id,
        name: destination.name,
        state: destination.state,
        address: destination.address,
        latitude: destination.latitude,
        longitude: destination.longitude
      } }

      returned_json = JSON.parse(response.body)

      expect(returned_json).to be_kind_of(Hash)
      expect(returned_json.length).to eq 8
      expect(returned_json["city"]).to eq "BOSTON"
      expect(Destination.find(destination.id).airport_id).to eq returned_json["id"]
    end
  end
end
