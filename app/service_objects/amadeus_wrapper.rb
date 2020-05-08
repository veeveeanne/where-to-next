require 'amadeus'

class AmadeusWrapper
  def self.fetch_airports(latitude, longitude)
    amadeus = Amadeus::Client.new
    response = amadeus.reference_data.locations.airports.get(
      latitude: latitude.to_f,
      longitude: longitude.to_f
    )
    results = response.data

    if results.length > 0
      airports = []

      results.each do |result|
        airport = {}

        airport[:name] = result["name"]
        airport[:iata_code] = result["iataCode"]
        airport[:city] = result["address"]["cityName"]
        airport[:latitude] = result["geoCode"]["latitude"]
        airport[:longitude] = result["geoCode"]["longitude"]

        airports.push(airport)
      end

      return airports
    else
      return "There was an error fetching the data from Amadeus"
    end
  end

  def self.fetch_suggested_airport(latitude, longitude)
    amadeus = Amadeus::Client.new
    response = amadeus.reference_data.locations.airports.get(
      latitude: latitude.to_f,
      longitude: longitude.to_f
    )
    results = response.data

    if results.length > 0
      airport = {}
      airport_response = results[0]

      airport[:name] = airport_response["name"]
      airport[:iata_code] = airport_response["iataCode"]
      airport[:city] = airport_response["address"]["cityName"]
      airport[:latitude] = airport_response["geoCode"]["latitude"]
      airport[:longitude] = airport_response["geoCode"]["longitude"]

      return airport
    else
      return "There was an error fetching the data from Amadeus"
    end
  end
end
