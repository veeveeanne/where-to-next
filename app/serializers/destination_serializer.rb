class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :name, :state, :address, :latitude, :longitude, :user_listing

  def user_listing
    object.listings.find_by(user: current_user)
  end
end
