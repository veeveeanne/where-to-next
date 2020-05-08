class Airport < ApplicationRecord
  has_many :destinations

  validates :name, presence: true
  validates :iata_code, presence: true, uniqueness: true
end
