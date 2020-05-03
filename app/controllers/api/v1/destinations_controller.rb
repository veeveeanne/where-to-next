require 'faraday'

class Api::V1::DestinationsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }


  def create
    query_string = params[:name].gsub(" ", "%20") << "%20" << params[:state].gsub(" ", "%20")

    url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{query_string}&inputtype=textquery&fields=photos,formatted_address,name,geometry&key=#{ENV["PLACES_API_KEY"]}"
    api_response = Faraday.get(url)
    parsed_response = JSON.parse(api_response.body)
    returned_result = parsed_response["candidates"][0]

    destination = Destination.new
    destination.name = returned_result["name"]
    destination.state = params["state"]
    destination.address = returned_result["formatted_address"]
    destination.latitude = returned_result["geometry"]["location"]["lat"]
    destination.longitude = returned_result["geometry"]["location"]["lng"]

    render json: destination
  end

  def index
    destinations = Destination.all
    render json: destinations
  end
end
