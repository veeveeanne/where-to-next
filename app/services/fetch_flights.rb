class FetchFlights

  def self.call(query)
    results = AmadeusWrapper.new.fetch_flights(query)

    if results.length > 0
      flight_prices = []
      results.each do |flight_offer|
        flight_prices.push(flight_offer['price']['total'].to_f)
      end

      return flight_prices
    else
      return 'There was an error fetching the data from Amadeus'
    end
  end
end
