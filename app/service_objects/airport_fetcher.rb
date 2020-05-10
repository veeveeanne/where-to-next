class AirportFetcher
  def self.request(latitude, longitude)
    AmadeusWrapper.fetch_airport(latitude, longitude)
  end
end
