class FetchAirport

  def self.call(latitude, longitude)
    results = AmadeusWrapper.new.fetch_airport(latitude, longitude)

    if results.length > 0
      airport = {}
      airport_response = results[0]

      airport[:name] = airport_response['name']
      airport[:iata_code] = airport_response['iataCode']
      airport[:city] = airport_response['address']['cityName']
      airport[:latitude] = airport_response['geoCode']['latitude']
      airport[:longitude] = airport_response['geoCode']['longitude']

      return airport
    else
      return 'There was an error fetching the data from Amadeus'
    end
  end
end
