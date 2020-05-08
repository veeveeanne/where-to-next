class Destination < ApplicationRecord
  belongs_to :airport, optional: true
  has_many :listings
  has_many :users, through: :listings

  validates :name, presence: true
  validates :state, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
