class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :name, :state, :address, :latitude, :longitude
end
