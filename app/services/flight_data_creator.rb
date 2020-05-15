class FlightDataCreator
  attr_reader :destinations, :params, :flight_options, :flight_prices

  def initialize(destinations, params)
    @destinations = destinations
    @params = params
    @flight_options = {}
    @flight_prices = {}
  end

  def search_flights
    flights = {}
    airports.each do |airport|
      if airport != @params['airport_code']
        query = search_helper(airport)
        response = FetchFlights.call(query)
        flights["#{airport}"] = response
      end
    end
    @flight_prices = flights
    return flights
  end

  def average(key)
    sum = @flight_prices[key].sum
    average = (sum/@flight_prices[key].count).round(2)
    @flight_options["#{key}"] = average

    return average
  end

  def suggested
    price = @flight_options.values.sort[0]
    destination = @flight_options.key(price)

    return destination
  end

  private
  def airports
    airports = @destinations.map do |listing|
      listing.destination.airport['iata_code']
    end

    return airports.uniq
  end

  def search_helper(airport)
    query = {
      origin: @params['airport_code'],
      destination: airport,
      departure_date: @params['departure_date'],
      return_date: @params['return_date']
    }
  end
end
