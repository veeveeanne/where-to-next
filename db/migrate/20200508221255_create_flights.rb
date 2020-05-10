class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :departure_iata, null: false
      t.string :destination_iata, null: false
      t.string :departure_date, null: false
      t.string :return_date, null: false
      t.float :average_price, null: false
      t.boolean :recommended, default: false
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
  end
end
