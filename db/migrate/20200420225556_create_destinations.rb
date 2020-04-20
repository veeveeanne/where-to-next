class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.string :name, null: false
      t.string :state, null: false

      t.timestamps null: false
    end
  end
end
