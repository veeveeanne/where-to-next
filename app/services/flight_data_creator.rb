class FlightDataCreator
  attr_reader :destinations, :params, :airports, :flight_options

  def initialize(destinations, params)
    @destinations = destinations
    @params = params
    @flight_options = {}
  end

  def search_flights
    flights = {}
    airports.each do |airport|
      query = search_helper(airport)
      response = FetchFlights.call(query)
      key = response.keys[0]
      flights["#{key}"] = response[key]
    end

    return flights
  end

  def average(key)
    sum = search_flights[key].sum
    average = (sum/search_flights[key].count).round(2)
    @flight_options["#{key}"] = average

    return average
  end

  def suggested
    price = @flight_options.values.sort[0]
    destination = @flight_options.key(price)

    return [destination, price]
  end

  private
  def search_helper(airport)
    query = {
      origin: @params['airport_code'],
      destination: airport,
      departure_date: @params['departure_date'],
      return_date: @params['return_date']
    }
  end

  def airports
    departure_airport = @params['airport_code']
    departure_city = Airport.find_by(iata_code: departure_airport)['city']
    airports_array = []

    @destinations.each do |listing|
      airport = listing.destination.airport
      if airport['city'] != departure_city
        airports_array.push(airport['iata_code'])
      end
    end

    airports = airports_array.uniq
  end
end
