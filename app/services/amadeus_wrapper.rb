require 'active_support/core_ext/module/delegation'

class AmadeusWrapper
  delegate :fetch_airport, :fetch_airports, :fetch_flights,
    to: :client

  protected
  def client
    if @client.nil?
      if Rails.env.test?
        @client = AmadeusFakeService.new
      else
        @client = AmadeusService.new
      end
    end
    @client
  end
end
