class AddCoordinatesToDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :destinations, :latitude, :decimal, {:null => false, :precision => 13, :scale => 10}
    add_column :destinations, :longitude, :decimal, {:null => false, :precision => 13, :scale => 10}
  end
end
