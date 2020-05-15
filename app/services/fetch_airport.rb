class FetchAirport

  def self.call(latitude, longitude)
    results = AmadeusWrapper.new.fetch_airport(latitude, longitude)

    if results.length > 0
      airport = {}
      airport_response = {}
      if results[0]['analytics']['travelers']['score'] > 10
        airport_response = results[0]
      else
        airport_response = results[1]
      end

      airport[:name] = airport_response['name']
      airport[:iata_code] = airport_response['iataCode']
      airport[:city] = airport_response['address']['cityName']
      airport[:state] = airport_response['address']['stateCode']
      airport[:latitude] = airport_response['geoCode']['latitude']
      airport[:longitude] = airport_response['geoCode']['longitude']

      return airport
    else
      return 'There was an error fetching the data from Amadeus'
    end
  end
end
