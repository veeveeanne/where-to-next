class Listing < ApplicationRecord
  belongs_to :destination
  belongs_to :user

  validates :destination_id, uniqueness: { scope: :user_id, 
    message: "has already been added to your list" }
end
