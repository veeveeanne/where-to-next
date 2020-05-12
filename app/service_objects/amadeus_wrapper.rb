# require 'amadeus'
#
# class AmadeusWrapper
#   def self.fetch_airport(latitude, longitude)
#     if Rails.env.test?
#       AmadeusWrapperTestHelper.fetch_airport
#     else
#       amadeus = Amadeus::Client.new
#       response = amadeus.reference_data.locations.airports.get(
#         latitude: latitude.to_f,
#         longitude: longitude.to_f
#       )
#       results = response.data
#
#       if results.length > 0
#         airport = {}
#         airport_response = results[0]
#
#         airport[:name] = airport_response['name']
#         airport[:iata_code] = airport_response['iataCode']
#         airport[:city] = airport_response['address']['cityName']
#         airport[:latitude] = airport_response['geoCode']['latitude']
#         airport[:longitude] = airport_response['geoCode']['longitude']
#
#         return airport
#       else
#         return 'There was an error fetching the data from Amadeus'
#       end
#     end
#   end
#
#   def self.fetch_airports(keyword)
#     if Rails.env.test?
#       AmadeusWrapperTestHelper.fetch_airports
#     else
#       amadeus = Amadeus::Client.new
#       response = amadeus.reference_data.locations.get(
#         keyword: keyword,
#         subType: Amadeus::Location::AIRPORT
#       )
#       results = response.data
#
#       if results.length > 0
#         airports = []
#
#         results.each_with_index do |airport_result, index|
#           airport = {}
#
#           if index === 0
#             airport[:name] = airport_result['name']
#             airport[:iata_code] = airport_result['iataCode']
#             airport[:city] = airport_result['address']['cityName']
#             airport[:latitude] = airport_result['geoCode']['latitude']
#             airport[:longitude] = airport_result['geoCode']['longitude']
#             airports.push(airport)
#           elsif airport_result['analytics'] && airport_result['analytics']['travelers']['score'] > 10
#             airport[:name] = airport_result['name']
#             airport[:iata_code] = airport_result['iataCode']
#             airport[:city] = airport_result['address']['cityName']
#             airport[:latitude] = airport_result['geoCode']['latitude']
#             airport[:longitude] = airport_result['geoCode']['longitude']
#             airports.push(airport)
#           end
#         end
#         return airports
#       else
#         return 'There was an error fetching the data from Amadeus'
#       end
#     end
#   end
#
#   def self.fetch_flights(query)
#     if Rails.env.test?
#       AmadeusWrapperTestHelper.fetch_flights
#     else
#       origin = query[:origin]
#       destination = query[:destination]
#       departure_date = query[:departure_date]
#       return_date = query[:return_date]
#
#       amadeus = Amadeus::Client.new
#       response = amadeus.shopping.flight_offers.get(
#         origin: origin,
#         destination: destination,
#         departureDate: departure_date,
#         returnDate: return_date
#       )
#       results = response.data
#
#       if results.length > 0
#         price_array = []
#         results.each do |offer_result|
#           price = offer_result['offerItems'][0]['pricePerAdult']['total'].to_f
#           price_array.push(price)
#         end
#         return flight = { "#{destination}" => price_array }
#       else
#         return 'There was an error fetching the data from Amadeus'
#       end
#     end
#   end
# end
