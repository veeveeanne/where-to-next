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
      {
      "type" => "flight-offer",
      "id" => "1",
      "source" => "GDS",
      "instantTicketingRequired" => false,
      "nonHomogeneous" => false,
      "oneWay" => false,
      "lastTicketingDate" => "2020-05-16",
      "numberOfBookableSeats" => 9,
      "itineraries" => [
        {
          "duration" => "PT6H16M",
          "segments" => [
            {
              "departure" => {
                "iataCode" => "BOS",
                "terminal" => "C",
                "at" => "2020-08-01T06:50:00"
              },
              "arrival" => {
                "iataCode" => "SEA",
                "at" => "2020-08-01T10:06:00"
              },
              "carrierCode" => "B6",
              "number" => "2397",
              "aircraft" => {
                "code" => "32S"
              },
              "operating" => {
                "carrierCode" => "B6"
              },
              "duration" => "PT6H16M",
              "id" => "1",
              "numberOfStops" => 0,
              "blacklistedInEU" => false
            }
          ]
        },
        {
          "duration" => "PT5H16M",
          "segments" => [
            {
              "departure" => {
                "iataCode" => "SEA",
                "at" => "2020-08-05T23:43:00"
              },
              "arrival" => {
                "iataCode" => "BOS",
                "terminal" => "C",
                "at" => "2020-08-06T07:59:00"
              },
              "carrierCode" => "B6",
              "number" => "498",
              "aircraft" => {
                "code" => "32S"
              },
              "operating" => {
                "carrierCode" => "B6"
              },
              "duration" => "PT5H16M",
              "id" => "3",
              "numberOfStops" => 0,
              "blacklistedInEU" => false
            }
          ]
        }
      ],
      "price" => {
        "currency" => "USD",
        "total" => "512.40",
        "base" => "472.00",
        "fees" => [
          {
            "amount" => "0.00",
            "type" => "SUPPLIER"
          },
          {
            "amount" => "0.00",
            "type" => "TICKETING"
          }
        ],
        "grandTotal" => "512.40"
      },
      "pricingOptions" => {
        "fareType" => [
          "PUBLISHED"
        ],
        "includedCheckedBagsOnly" => false
      },
      "validatingAirlineCodes" => [
        "B6"
      ],
      "travelerPricings" => [
        {
          "travelerId" => "1",
          "fareOption" => "STANDARD",
          "travelerType" => "ADULT",
          "price" => {
            "currency" => "USD",
            "total" => "256.20",
            "base" => "236.00"
          },
          "fareDetailsBySegment" => [
            {
              "segmentId" => "1",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            },
            {
              "segmentId" => "3",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            }
          ]
        },
        {
          "travelerId" => "2",
          "fareOption" => "STANDARD",
          "travelerType" => "ADULT",
          "price" => {
            "currency" => "USD",
            "total" => "256.20",
            "base" => "236.00"
          },
          "fareDetailsBySegment" => [
            {
              "segmentId" => "1",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            },
            {
              "segmentId" => "3",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            }
          ]
        }
      ]
    },
    {
      "type" => "flight-offer",
      "id" => "2",
      "source" => "GDS",
      "instantTicketingRequired" => false,
      "nonHomogeneous" => false,
      "oneWay" => false,
      "lastTicketingDate" => "2020-05-16",
      "numberOfBookableSeats" => 9,
      "itineraries" => [
        {
          "duration" => "PT6H16M",
          "segments" => [
            {
              "departure" => {
                "iataCode" => "BOS",
                "terminal" => "C",
                "at" => "2020-08-01T06:50:00"
              },
              "arrival" => {
                "iataCode" => "SEA",
                "at" => "2020-08-01T10:06:00"
              },
              "carrierCode" => "B6",
              "number" => "2397",
              "aircraft" => {
                "code" => "32S"
              },
              "operating" => {
                "carrierCode" => "B6"
              },
              "duration" => "PT6H16M",
              "id" => "1",
              "numberOfStops" => 0,
              "blacklistedInEU" => false
            }
          ]
        },
        {
          "duration" => "PT5H28M",
          "segments" => [
            {
              "departure" => {
                "iataCode" => "SEA",
                "at" => "2020-08-05T11:16:00"
              },
              "arrival" => {
                "iataCode" => "BOS",
                "terminal" => "C",
                "at" => "2020-08-05T19:44:00"
              },
              "carrierCode" => "B6",
              "number" => "2398",
              "aircraft" => {
                "code" => "32S"
              },
              "operating" => {
                "carrierCode" => "B6"
              },
              "duration" => "PT5H28M",
              "id" => "4",
              "numberOfStops" => 0,
              "blacklistedInEU" => false
            }
          ]
        }
      ],
      "price" => {
        "currency" => "USD",
        "total" => "512.40",
        "base" => "472.00",
        "fees" => [
          {
            "amount" => "0.00",
            "type" => "SUPPLIER"
          },
          {
            "amount" => "0.00",
            "type" => "TICKETING"
          }
        ],
        "grandTotal" => "512.40"
      },
      "pricingOptions" => {
        "fareType" => [
          "PUBLISHED"
        ],
        "includedCheckedBagsOnly" => false
      },
      "validatingAirlineCodes" => [
        "B6"
      ],
      "travelerPricings" => [
        {
          "travelerId" => "1",
          "fareOption" => "STANDARD",
          "travelerType" => "ADULT",
          "price" => {
            "currency" => "USD",
            "total" => "256.20",
            "base" => "236.00"
          },
          "fareDetailsBySegment" => [
            {
              "segmentId" => "1",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            },
            {
              "segmentId" => "4",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            }
          ]
        },
        {
          "travelerId" => "2",
          "fareOption" => "STANDARD",
          "travelerType" => "ADULT",
          "price" => {
            "currency" => "USD",
            "total" => "256.20",
            "base" => "236.00"
          },
          "fareDetailsBySegment" => [
            {
              "segmentId" => "1",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            },
            {
              "segmentId" => "4",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            }
          ]
        }
      ]
    },
    {
      "type" => "flight-offer",
      "id" => "3",
      "source" => "GDS",
      "instantTicketingRequired" => false,
      "nonHomogeneous" => false,
      "oneWay" => false,
      "lastTicketingDate" => "2020-05-16",
      "numberOfBookableSeats" => 9,
      "itineraries" => [
        {
          "duration" => "PT6H16M",
          "segments" => [
            {
              "departure" => {
                "iataCode" => "BOS",
                "terminal" => "C",
                "at" => "2020-08-01T06:50:00"
              },
              "arrival" => {
                "iataCode" => "SEA",
                "at" => "2020-08-01T10:06:00"
              },
              "carrierCode" => "B6",
              "number" => "2397",
              "aircraft" => {
                "code" => "32S"
              },
              "operating" => {
                "carrierCode" => "B6"
              },
              "duration" => "PT6H16M",
              "id" => "1",
              "numberOfStops" => 0,
              "blacklistedInEU" => false
            }
          ]
        },
        {
          "duration" => "PT5H31M",
          "segments" => [
            {
              "departure" => {
                "iataCode" => "SEA",
                "at" => "2020-08-05T13:56:00"
              },
              "arrival" => {
                "iataCode" => "BOS",
                "terminal" => "C",
                "at" => "2020-08-05T22:27:00"
              },
              "carrierCode" => "B6",
              "number" => "298",
              "aircraft" => {
                "code" => "320"
              },
              "operating" => {
                "carrierCode" => "B6"
              },
              "duration" => "PT5H31M",
              "id" => "5",
              "numberOfStops" => 0,
              "blacklistedInEU" => false
            }
          ]
        }
      ],
      "price" => {
        "currency" => "USD",
        "total" => "512.40",
        "base" => "472.00",
        "fees" => [
          {
            "amount" => "0.00",
            "type" => "SUPPLIER"
          },
          {
            "amount" => "0.00",
            "type" => "TICKETING"
          }
        ],
        "grandTotal" => "512.40"
      },
      "pricingOptions" => {
        "fareType" => [
          "PUBLISHED"
        ],
        "includedCheckedBagsOnly" => false
      },
      "validatingAirlineCodes" => [
        "B6"
      ],
      "travelerPricings" => [
        {
          "travelerId" => "1",
          "fareOption" => "STANDARD",
          "travelerType" => "ADULT",
          "price" => {
            "currency" => "USD",
            "total" => "256.20",
            "base" => "236.00"
          },
          "fareDetailsBySegment" => [
            {
              "segmentId" => "1",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            },
            {
              "segmentId" => "5",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            }
          ]
        },
        {
          "travelerId" => "2",
          "fareOption" => "STANDARD",
          "travelerType" => "ADULT",
          "price" => {
            "currency" => "USD",
            "total" => "256.20",
            "base" => "236.00"
          },
          "fareDetailsBySegment" => [
            {
              "segmentId" => "1",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            },
            {
              "segmentId" => "5",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            }
          ]
        }
      ]
    },
    {
      "type" => "flight-offer",
      "id" => "4",
      "source" => "GDS",
      "instantTicketingRequired" => false,
      "nonHomogeneous" => false,
      "oneWay" => false,
      "lastTicketingDate" => "2020-05-16",
      "numberOfBookableSeats" => 9,
      "itineraries" => [
        {
          "duration" => "PT6H20M",
          "segments" => [
            {
              "departure" => {
                "iataCode" => "BOS",
                "terminal" => "C",
                "at" => "2020-08-01T09:46:00"
              },
              "arrival" => {
                "iataCode" => "SEA",
                "at" => "2020-08-01T13:06:00"
              },
              "carrierCode" => "B6",
              "number" => "297",
              "aircraft" => {
                "code" => "320"
              },
              "operating" => {
                "carrierCode" => "B6"
              },
              "duration" => "PT6H20M",
              "id" => "2",
              "numberOfStops" => 0,
              "blacklistedInEU" => false
            }
          ]
        },
        {
          "duration" => "PT5H16M",
          "segments" => [
            {
              "departure" => {
                "iataCode" => "SEA",
                "at" => "2020-08-05T23:43:00"
              },
              "arrival" => {
                "iataCode" => "BOS",
                "terminal" => "C",
                "at" => "2020-08-06T07:59:00"
              },
              "carrierCode" => "B6",
              "number" => "498",
              "aircraft" => {
                "code" => "32S"
              },
              "operating" => {
                "carrierCode" => "B6"
              },
              "duration" => "PT5H16M",
              "id" => "3",
              "numberOfStops" => 0,
              "blacklistedInEU" => false
            }
          ]
        }
      ],
      "price" => {
        "currency" => "USD",
        "total" => "512.40",
        "base" => "472.00",
        "fees" => [
          {
            "amount" => "0.00",
            "type" => "SUPPLIER"
          },
          {
            "amount" => "0.00",
            "type" => "TICKETING"
          }
        ],
        "grandTotal" => "512.40"
      },
      "pricingOptions" => {
        "fareType" => [
          "PUBLISHED"
        ],
        "includedCheckedBagsOnly" => false
      },
      "validatingAirlineCodes" => [
        "B6"
      ],
      "travelerPricings" => [
        {
          "travelerId" => "1",
          "fareOption" => "STANDARD",
          "travelerType" => "ADULT",
          "price" => {
            "currency" => "USD",
            "total" => "256.20",
            "base" => "236.00"
          },
          "fareDetailsBySegment" => [
            {
              "segmentId" => "2",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            },
            {
              "segmentId" => "3",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            }
          ]
        },
        {
          "travelerId" => "2",
          "fareOption" => "STANDARD",
          "travelerType" => "ADULT",
          "price" => {
            "currency" => "USD",
            "total" => "256.20",
            "base" => "236.00"
          },
          "fareDetailsBySegment" => [
            {
              "segmentId" => "2",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            },
            {
              "segmentId" => "3",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            }
          ]
        }
      ]
    },
    {
      "type" => "flight-offer",
      "id" => "5",
      "source" => "GDS",
      "instantTicketingRequired" => false,
      "nonHomogeneous" => false,
      "oneWay" => false,
      "lastTicketingDate" => "2020-05-16",
      "numberOfBookableSeats" => 9,
      "itineraries" => [
        {
          "duration" => "PT6H20M",
          "segments" => [
            {
              "departure" => {
                "iataCode" => "BOS",
                "terminal" => "C",
                "at" => "2020-08-01T09:46:00"
              },
              "arrival" => {
                "iataCode" => "SEA",
                "at" => "2020-08-01T13:06:00"
              },
              "carrierCode" => "B6",
              "number" => "297",
              "aircraft" => {
                "code" => "320"
              },
              "operating" => {
                "carrierCode" => "B6"
              },
              "duration" => "PT6H20M",
              "id" => "2",
              "numberOfStops" => 0,
              "blacklistedInEU" => false
            }
          ]
        },
        {
          "duration" => "PT5H28M",
          "segments" => [
            {
              "departure" => {
                "iataCode" => "SEA",
                "at" => "2020-08-05T11:16:00"
              },
              "arrival" => {
                "iataCode" => "BOS",
                "terminal" => "C",
                "at" => "2020-08-05T19:44:00"
              },
              "carrierCode" => "B6",
              "number" => "2398",
              "aircraft" => {
                "code" => "32S"
              },
              "operating" => {
                "carrierCode" => "B6"
              },
              "duration" => "PT5H28M",
              "id" => "4",
              "numberOfStops" => 0,
              "blacklistedInEU" => false
            }
          ]
        }
      ],
      "price" => {
        "currency" => "USD",
        "total" => "512.40",
        "base" => "472.00",
        "fees" => [
          {
            "amount" => "0.00",
            "type" => "SUPPLIER"
          },
          {
            "amount" => "0.00",
            "type" => "TICKETING"
          }
        ],
        "grandTotal" => "512.40"
      },
      "pricingOptions" => {
        "fareType" => [
          "PUBLISHED"
        ],
        "includedCheckedBagsOnly" => false
      },
      "validatingAirlineCodes" => [
        "B6"
      ],
      "travelerPricings" => [
        {
          "travelerId" => "1",
          "fareOption" => "STANDARD",
          "travelerType" => "ADULT",
          "price" => {
            "currency" => "USD",
            "total" => "256.20",
            "base" => "236.00"
          },
          "fareDetailsBySegment" => [
            {
              "segmentId" => "2",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            },
            {
              "segmentId" => "4",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            }
          ]
        },
        {
          "travelerId" => "2",
          "fareOption" => "STANDARD",
          "travelerType" => "ADULT",
          "price" => {
            "currency" => "USD",
            "total" => "256.20",
            "base" => "236.00"
          },
          "fareDetailsBySegment" => [
            {
              "segmentId" => "2",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            },
            {
              "segmentId" => "4",
              "cabin" => "ECONOMY",
              "fareBasis" => "PI2QBOL1",
              "brandedFare" => "DN",
              "class" => "L",
              "includedCheckedBags" => {
                "quantity" => 0
              }
            }
          ]
        }
      ]
    }
  ]
  end
end
