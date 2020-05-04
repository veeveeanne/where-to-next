class Destination < ApplicationRecord
  has_many :listings
  has_many :users, through: :listings

  validates :name, presence: true
  validates :state, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
