class Destination < ApplicationRecord
  validates :name, presence: true
  validates :state, presence: true
end
