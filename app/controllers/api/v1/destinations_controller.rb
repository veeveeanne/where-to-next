class Api::V1::DestinationsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    destination = Destination.new
    destination.name = params[:name]
    destination.state = params[:state]
    destination.save
  end

  def index
    destinations = Destination.all
    render json: destinations
  end
end
