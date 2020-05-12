class FetchFlights

  def self.call(query)
    results = AmadeusService.fetch_flights(query)

    if results.length > 0
      price_array = []
      results.each do |offer_result|
        price = offer_result['offerItems'][0]['pricePerAdult']['total'].to_f
        price_array.push(price)
      end
      return flight = { "#{query[:destination]}" => price_array }
    else
      return 'There was an error fetching the data from Amadeus'
    end
  end
end
