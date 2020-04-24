class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.belongs_to :destination, null: false
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
  end
end
