class AddVisitedToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :visited, :boolean, :default => false
  end
end
