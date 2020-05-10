class AirportsFetcher
  def self.request(keyword)
    AmadeusWrapper.fetch_airports(keyword)
  end
end
