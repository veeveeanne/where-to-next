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
    results = [
      {"type"=>"flight-offer",
  "id"=>"1589319326765-680962903",
  "offerItems"=>
   [{"services"=>
      [{"segments"=>
         [{"flightSegment"=>
            {"departure"=>{"iataCode"=>"BOS", "terminal"=>"A", "at"=>"2020-08-01T11:03:00-04:00"},
             "arrival"=>{"iataCode"=>"JFK", "terminal"=>"4", "at"=>"2020-08-01T12:30:00-04:00"},
             "carrierCode"=>"DL",
             "number"=>"5626",
             "aircraft"=>{"code"=>"E70"},
             "operating"=>{"number"=>"5626"},
             "duration"=>"0DT1H27M"},
           "pricingDetailPerAdult"=>{"travelClass"=>"ECONOMY", "fareClass"=>"E", "availability"=>7, "fareBasis"=>"UAVNA0BC"}},
          {"flightSegment"=>
            {"departure"=>{"iataCode"=>"JFK", "terminal"=>"4", "at"=>"2020-08-01T15:55:00-04:00"},
             "arrival"=>{"iataCode"=>"SEA", "at"=>"2020-08-01T19:10:00-07:00"},
             "carrierCode"=>"DL",
             "number"=>"2699",
             "aircraft"=>{"code"=>"75W"},
             "operating"=>{"carrierCode"=>"DL", "number"=>"2699"},
             "duration"=>"0DT6H15M"},
           "pricingDetailPerAdult"=>{"travelClass"=>"ECONOMY", "fareClass"=>"E", "availability"=>9, "fareBasis"=>"UAVNA0BC"}}]},
       {"segments"=>
         [{"flightSegment"=>
            {"departure"=>{"iataCode"=>"SEA", "at"=>"2020-08-05T14:05:00-07:00"},
             "arrival"=>{"iataCode"=>"MSP", "terminal"=>"1", "at"=>"2020-08-05T19:31:00-05:00"},
             "carrierCode"=>"DL",
             "number"=>"3043",
             "aircraft"=>{"code"=>"752"},
             "operating"=>{"carrierCode"=>"DL", "number"=>"3043"},
             "duration"=>"0DT3H26M"},
           "pricingDetailPerAdult"=>{"travelClass"=>"ECONOMY", "fareClass"=>"E", "availability"=>9, "fareBasis"=>"VAVSH3BC"}},
          {"flightSegment"=>
            {"departure"=>{"iataCode"=>"MSP", "terminal"=>"1", "at"=>"2020-08-05T20:20:00-05:00"},
             "arrival"=>{"iataCode"=>"BOS", "terminal"=>"A", "at"=>"2020-08-06T00:10:00-04:00"},
             "carrierCode"=>"DL",
             "number"=>"1218",
             "aircraft"=>{"code"=>"321"},
             "operating"=>{"carrierCode"=>"DL", "number"=>"1218"},
             "duration"=>"0DT2H50M"},
           "pricingDetailPerAdult"=>{"travelClass"=>"ECONOMY", "fareClass"=>"E", "availability"=>9, "fareBasis"=>"VAVSH3BC"}}]}],
     "price"=>{"total"=>"329.06", "totalTaxes"=>"27.06"},
     "pricePerAdult"=>{"total"=>"329.06", "totalTaxes"=>"27.06"}}]}
    ]
  end
end
