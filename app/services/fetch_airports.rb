class FetchAirports

  def self.call(keyword)
    results = AmadeusService.fetch_airports(keyword)

    if results.length > 0
      airports = []

      results.each_with_index do |airport_result, index|
        airport = {}

        if index === 0
          airport[:name] = airport_result['name']
          airport[:iata_code] = airport_result['iataCode']
          airport[:city] = airport_result['address']['cityName']
          airport[:latitude] = airport_result['geoCode']['latitude']
          airport[:longitude] = airport_result['geoCode']['longitude']
          airports.push(airport)
        elsif airport_result['analytics'] && airport_result['analytics']['travelers']['score'] > 10
          airport[:name] = airport_result['name']
          airport[:iata_code] = airport_result['iataCode']
          airport[:city] = airport_result['address']['cityName']
          airport[:latitude] = airport_result['geoCode']['latitude']
          airport[:longitude] = airport_result['geoCode']['longitude']
          airports.push(airport)
        end
      end
      return airports
    else
      return 'There was an error fetching the data from Amadeus'
    end
  end
end
