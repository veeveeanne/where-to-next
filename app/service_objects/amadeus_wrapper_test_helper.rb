class AmadeusWrapperTestHelper
  def self.fetch_airport
    VCR.use_cassette("amadeus_token") do
      returned_response = Faraday.post do |request|
        request.url 'https://test.api.amadeus.com/v1/security/oauth2/token'
        request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        request.body = "grant_type=client_credentials&client_id=#{ENV["AMADEUS_CLIENT_ID"]}&client_secret=#{ENV["AMADEUS_CLIENT_SECRET"]}"
      end

      parsed_response = JSON.parse(returned_response.body)
      token = parsed_response["access_token"]

      VCR.use_cassette("fetch_airport") do
        airport_response = Faraday.get do |request|
          request.url 'https://test.api.amadeus.com/v1/reference-data/locations/airports?latitude=42.361145&longitude=-71.057083'
          request.headers['Authorization'] = "Bearer #{token}"
        end

        parsed_result = JSON.parse(airport_response.body)
        results = parsed_result["data"]

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
  end

  def self.fetch_airports
    VCR.use_cassette("amadeus_token") do
      returned_response = Faraday.post do |request|
        request.url 'https://test.api.amadeus.com/v1/security/oauth2/token'
        request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        request.body = "grant_type=client_credentials&client_id=#{ENV["AMADEUS_CLIENT_ID"]}&client_secret=#{ENV["AMADEUS_CLIENT_SECRET"]}"
      end

      parsed_response = JSON.parse(returned_response.body)
      token = parsed_response["access_token"]

      VCR.use_cassette("fetch_airports") do
        airports_response = Faraday.get do |request|
          request.url 'https://test.api.amadeus.com/v1/reference-data/locations?subType=AIRPORT&keyword=boston&page[limit]=5'
          request.headers['Authorization'] = "Bearer #{token}"
        end

        parsed_results = JSON.parse(airports_response.body)
        results = parsed_results["data"]

        if results.length > 0
          airports = []

          results.each_with_index do |airport_result, index|
            airport = {}

            if index === 0
              airport[:name] = airport_result["name"]
              airport[:iata_code] = airport_result["iataCode"]
              airport[:city] = airport_result["address"]["cityName"]
              airport[:latitude] = airport_result["geoCode"]["latitude"]
              airport[:longitude] = airport_result["geoCode"]["longitude"]
              airports.push(airport)
            elsif airport_result["analytics"] && airport_result["analytics"]["travelers"]["score"] > 10
              airport[:name] = airport_result["name"]
              airport[:iata_code] = airport_result["iataCode"]
              airport[:city] = airport_result["address"]["cityName"]
              airport[:latitude] = airport_result["geoCode"]["latitude"]
              airport[:longitude] = airport_result["geoCode"]["longitude"]
              airports.push(airport)
            end
          end
          return airports
        else
          return "There was an error fetching the data from Amadeus"
        end
      end
    end
  end

  def self.fetch_flights
    VCR.use_cassette("amadeus_token") do
      returned_response = Faraday.post do |request|
        request.url 'https://test.api.amadeus.com/v1/security/oauth2/token'
        request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        request.body = "grant_type=client_credentials&client_id=#{ENV["AMADEUS_CLIENT_ID"]}&client_secret=#{ENV["AMADEUS_CLIENT_SECRET"]}"
      end

      parsed_response = JSON.parse(returned_response.body)
      token = parsed_response["access_token"]

      VCR.use_cassette("fetch_flights") do
        flights_response = Faraday.get do |request|
          request.url 'https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=BOS&destinationLocationCode=SEA&departureDate=2020-08-01&returnDate=2020-08-05&adults=1&currencyCode=USD'
          request.headers['Authorization'] = "Bearer #{token}"
        end

        parsed_results = JSON.parse(flights_response.body)
        results = parsed_results["data"]

        if results.length > 0
          price_array = []
          results.each do |offer_result|
            price = offer_result['price']['total'].to_f
            price_array.push(price)
          end
          return flight = { "SEA" => price_array }
        else
          return 'There was an error fetching the data from Amadeus'
        end
      end
    end
  end
end
