class Airport < ApplicationRecord
  has_many :destinations

  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :iata_code, presence: true, uniqueness: true
end
