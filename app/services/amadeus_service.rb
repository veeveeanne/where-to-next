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

    response = amadeus.shopping.flight_offers.get(
      origin: origin,
      destination: destination,
      departureDate: departure_date,
      returnDate: return_date
    )
    results = response.data
  end
end
