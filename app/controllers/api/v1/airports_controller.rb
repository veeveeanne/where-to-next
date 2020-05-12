class Api::V1::AirportsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    latitude = params["destination"]["latitude"].to_f
    longitude = params["destination"]["longitude"].to_f

    airport_response = FetchAirport.call(latitude, longitude)

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

    render json: airport
  end

  def search
    airports = Airport.where("name ILIKE ? OR city ILIKE ?", "%" + params["keyword"] + "%", "%" + params["keyword"] + "%")

    render json: airports
  end

  def explore
    keyword = params["keyword"]

    airports_response = FetchAirports.call(keyword)

    if airports_response.length > 0
      airports = []
      airports_response.each do |airport_response|
        airport = Airport.create(
          name: airport_response[:name],
          iata_code: airport_response[:iata_code],
          latitude: airport_response[:latitude],
          longitude: airport_response[:longitude],
          city: airport_response[:city]
        )
        airports.push(airport)
      end

      render json: airports
    else
      render json: { error: "could not be found. Please try searching again"}
    end
  end
end
