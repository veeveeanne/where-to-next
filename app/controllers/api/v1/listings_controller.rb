class Api::V1::ListingsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    listing = Listing.new
    listing.destination_id = params["id"]
    listing.user = current_user
    listing.save

    render json: listing
  end

  def search
    destinations = Destination.where("name ILIKE ? AND state LIKE ?", "%" + params["name"] + "%", params["state"])

    render json: destinations
  end
end
