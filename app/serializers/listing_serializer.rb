class ListingSerializer < ActiveModel::Serializer
  attributes :id, :visited

  belongs_to :destination
end
