require 'faraday'
require 'active_support'

class Api::V1::DestinationsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    destination = Destination.where(latitude: params["latitude"].to_d, longitude: params["longitude"].to_d).first_or_create do |destination|
      destination.name = params["name"]
      destination.state = params["state"]
      destination.address = params["address"]
      destination.latitude = params["latitude"]
      destination.longitude = params["longitude"]
    end

    render json: destination
  end

  def index
    destinations = Destination.all

    render json: destinations
  end

  def search
    query_string = params[:query].gsub(" ", "%20")

    url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{query_string}&key=#{ENV["PLACES_API_KEY"]}"
    api_response = Faraday.get(url)
    parsed_response = JSON.parse(api_response.body)
    results = parsed_response["results"]

    render json: {results: results}
  end
end
