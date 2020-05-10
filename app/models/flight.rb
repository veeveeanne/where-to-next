class Flight < ApplicationRecord
  belongs_to :user

  validates :departure_iata, presence: true
  validates :destination_iata, presence: true
  validates :departure_date, presence: true
  validates :return_date, presence: true
  validates :average_price, presence: true, numericality: true
end
