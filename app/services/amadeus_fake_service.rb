class AmadeusFakeService
  cattr_reader :amadeus do
    Amadeus::Client.new
  end

  def fetch_airport(latitude, longitude)
    results = [
        {
            "type"=> "location",
            "subType"=> "AIRPORT",
            "name"=> "EDWARD L LOGAN INTL",
            "detailedName"=> "BOSTON/MA/US:EDWARD L LOGAN IN",
            "timeZoneOffset": "-04:00",
            "iataCode"=> "BOS",
            "geoCode"=> {
                "latitude"=> 42.36514,
                "longitude"=> -71.01777
            },
            "address"=> {
                "cityName"=> "BOSTON",
                "cityCode"=> "BOS",
                "countryName"=> "UNITED STATES OF AMERICA",
                "countryCode"=> "US",
                "stateCode"=> "MA",
                "regionCode"=> "NAMER"
            },
            "distance"=> {
                "value"=> 3,
                "unit"=> "KM"
            },
            "analytics"=> {
                "flights"=> {
                    "score"=> 29
                },
                "travelers"=> {
                    "score"=> 23
                }
            },
            "relevance"=> 878.70715
        }
    ]
  end

  def fetch_airports(keyword)
    results = [
          {
              "type"=> "location",
              "subType"=> "AIRPORT",
              "name"=> "EDWARD L LOGAN INTL",
              "detailedName"=> "BOSTON/MA/US:EDWARD L LOGAN IN",
              "id"=> "ABOS",
              "self"=> {
                  "href": "https://test.api.amadeus.com/v1/reference-data/locations/ABOS",
                  "methods": [
                      "GET"
                  ]
              },
              "timeZoneOffset": "-04:00",
              "iataCode"=> "BOS",
              "geoCode"=> {
                  "latitude"=> 42.36514,
                  "longitude"=> -71.01777
              },
              "address"=> {
                  "cityName"=> "BOSTON",
                  "cityCode"=> "BOS",
                  "countryName"=> "UNITED STATES OF AMERICA",
                  "countryCode"=> "US",
                  "stateCode"=> "MA",
                  "regionCode"=> "NAMER"
              },
              "analytics"=> {
                  "travelers"=> {
                      "score"=> 23
                  }
              }
          }
    ]
  end

  def fetch_flights(query)
    results = {
      'SEA' => [256.20, 512.40, 256.20, 256.20, 512.40]
    }
  end
end
