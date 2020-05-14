# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_14_171151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airports", force: :cascade do |t|
    t.string "name", null: false
    t.string "iata_code", null: false
    t.decimal "latitude", null: false
    t.decimal "longitude", null: false
    t.string "city", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state", null: false
    t.index ["iata_code"], name: "index_airports_on_iata_code", unique: true
  end

  create_table "destinations", force: :cascade do |t|
    t.string "name", null: false
    t.string "state", null: false
    t.bigint "airport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "latitude", precision: 13, scale: 10, null: false
    t.decimal "longitude", precision: 13, scale: 10, null: false
    t.string "address", null: false
    t.index ["airport_id"], name: "index_destinations_on_airport_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "departure_iata", null: false
    t.string "destination_iata", null: false
    t.string "departure_date", null: false
    t.string "return_date", null: false
    t.float "average_price", null: false
    t.boolean "recommended", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_flights_on_user_id"
  end

  create_table "listings", force: :cascade do |t|
    t.bigint "destination_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visited", default: false
    t.index ["destination_id", "user_id"], name: "by_destination_and_user", unique: true
    t.index ["destination_id"], name: "index_listings_on_destination_id"
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
