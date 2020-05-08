class CreateAirports < ActiveRecord::Migration[5.2]
  def change
    create_table :airports do |t|
      t.string :name, null: false
      t.string :iata_code, null: false
      t.decimal :latitude, null: false
      t.decimal :longitude, null: false
      t.string :city, null: false

      t.timestamps null: false

      t.index :iata_code, unique: true
    end
  end
end
