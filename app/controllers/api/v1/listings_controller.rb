class Api::V1::ListingsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    listing = Listing.new
    listing.destination_id = params["id"]
    listing.user = current_user
    listing.save

    if listing.save
      render json: listing.destination
    else
      render json: { error: listing.errors.messages[:destination_id].to_sentence }
    end
  end

  def index
    render json: current_user.destinations
  end

  def show
    render json: Listing.find(params["id"]).destination
  end

  def update
    listing = Listing.find(params["id"])
    listing.visited = params["visited"]
    listing.save

    render json: listing
  end

  def destroy
    listing = Listing.find(params["id"])
    listing.delete

    render json: current_user.listings
  end

  def search
    destinations = Destination.where("name ILIKE ? AND state LIKE ?", params["name"], params["state"])

    render json: destinations
  end
end
