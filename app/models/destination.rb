class Destination < ApplicationRecord
  has_many :listings
  has_many :users, through: :listings

  validates :name, presence: true
  validates :state, presence: true
end
