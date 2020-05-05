class AddIndexToListings < ActiveRecord::Migration[5.2]
  def change
    add_index :listings, [ :destination_id, :user_id ], :unique => true, :name => 'by_destination_and_user'
  end
end
