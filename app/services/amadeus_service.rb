require 'amadeus'

class AmadeusService
  cattr_reader :amadeus do
    Amadeus::Client.new
  end

  def fetch_airport(latitude, longitude)
    response = amadeus.reference_data.locations.airports.get(
      latitude: latitude.to_f,
      longitude: longitude.to_f
    )
    results = response.data
  end

  def fetch_airports(keyword)
    response = amadeus.reference_data.locations.get(
      keyword: keyword,
      subType: Amadeus::Location::AIRPORT
    )
    results = response.data
  end

  def fetch_flights(query)
    origin = query[:origin]
    destination = query[:destination]
    departure_date = query[:departure_date]
    return_date = query[:return_date]

    response = amadeus.shopping.flight_offers_search.get(
      originLocationCode: origin,
      destinationLocationCode: destination,
      departureDate: departure_date,
      returnDate: return_date,
      adults: 1,
      currencyCode: "USD",
      max: 5
    )

    results = response.data
    flight = {}
    flight_prices = []
    results.each do |flight_offer|
      flight_prices.push(flight_offer['price']['total'].to_f)
    end
    flight["#{destination}"] = flight_prices
    return flight
  end
end
