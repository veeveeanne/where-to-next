class AddCoordinatesToDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :destinations, :latitude, :decimal, {:precision => 13, :scale => 10}
    add_column :destinations, :longitude, :decimal, {:precision => 13, :scale => 10}
  end
end
