class Api::V1::AirportsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    latitude = params["destination"]["latitude"].to_f
    longitude = params["destination"]["longitude"].to_f

    airport_response = AmadeusWrapper.fetch_suggested_airport(latitude, longitude)

    airport = Airport.where(iata_code: airport_response[:iata_code]).first_or_create do |airport|
      airport.name = airport_response[:name]
      airport.iata_code = airport_response[:iata_code]
      airport.latitude = airport_response[:latitude]
      airport.longitude = airport_response[:longitude]
      airport.city = airport_response[:city]
    end

    destination = Destination.find(params["destination"]["id"])
    destination.airport = airport
    destination.save

    if destination.save
      render json: airport
    else
      render json: { error: destination.errors.full_messages.to_sentence }
    end
  end
end
