class Api::V1::FlightsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    departure_iata = params['airport_code']
    departure_date = params['departure_date']
    return_date = params['return_date']

    destinations_to_visit = current_user.listings.where(visited: false)
    airports_array = []
    destinations_to_visit.each do |listing|
      airport = listing.destination.airport
      airports_array.push(airport['iata_code'])
    end

    airports = airports_array.uniq.filter { |iata| iata != departure_iata }
    flights = {}
    airports.each do |airport|
      query = {
        origin: departure_iata,
        destination: airport,
        departure_date: departure_date,
        return_date: return_date
      }
      response = AmadeusWrapper.fetch_flights(query)
      key = response.keys[0]
      flights["#{key}"] = response[key]
    end

    flight_options = {}
    flights.each_key do |key|
      sum = flights[key].sum
      average = (sum/flights[key].count).round(2)
      flight = Flight.new
      flight.departure_iata = departure_iata
      flight.destination_iata = key
      flight.departure_date = departure_date
      flight.return_date = return_date
      flight.average_price = average
      flight.user = current_user
      flight.save

      flight_options["#{key}"] = average
    end
    
    cheapest_flight = flight_options.values.sort[0]
    suggested_destination = flight_options.key(cheapest_flight)
    suggested_flight = Flight.find_by(destination_iata: suggested_destination, average_price: cheapest_flight)
    suggested_flight.recommended = true
    suggested_flight.save
    airport = Airport.find_by(iata_code: suggested_destination)

    render json: airport
  end
end
