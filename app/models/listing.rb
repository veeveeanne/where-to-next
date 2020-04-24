class Listing < ApplicationRecord
  belongs_to :destination
  belongs_to :user
end
