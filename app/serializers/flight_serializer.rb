class FlightSerializer < ActiveModel::Serializer
  attributes :id, :departure_airport, :destination_airport, :destinations

  def departure_airport
    Airport.find_by(iata_code: object.departure_iata)
  end

  def destination_airport
    Airport.find_by(iata_code: object.destination_iata)
  end

  def destinations
    Destination.where(airport: destination_airport)
  end
end
