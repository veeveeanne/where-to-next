class Api::V1::FlightsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    destinations_to_visit = current_user.listings.where(visited: false)
    if destinations_to_visit.length > 0
      flight_creator = FlightDataCreator.new(destinations_to_visit, params)
      flights = flight_creator.search_flights

      flights.each_key do |key|
        flight = Flight.new
        flight.departure_iata = params['airport_code']
        flight.destination_iata = key
        flight.departure_date = params['departure_date']
        flight.return_date = params['return_date']
        flight.average_price = flight_creator.average(key)
        flight.user = current_user
        flight.save
      end

      suggestion = flight_creator.suggested
      flight = Flight.where(destination_iata: suggestion).last
      flight.recommended = true
      flight.save

      render json: flight
    else
      render json: { flight: {} }
    end
  end

  def index
    flight = Flight.where(user: current_user, recommended: true).last

    if !flight
      render json: { flight: {} }
    else
      render json: flight
    end
  end
end
