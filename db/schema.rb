# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_15_045636) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_logs", force: :cascade do |t|
    t.string "name"
    t.jsonb "log"
    t.string "from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.integer "amenity_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso_alpha2_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", id: :string, force: :cascade do |t|
    t.integer "destination_id", null: false
    t.string "name"
    t.text "description"
    t.text "booking_conditions", array: true
    t.float "lat"
    t.float "lng"
    t.string "address"
    t.string "city"
    t.integer "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "postal_code"
    t.index ["destination_id"], name: "index_hotels_on_destination_id"
    t.index ["id"], name: "index_hotels_on_id"
  end

  create_table "hotels_amenities", force: :cascade do |t|
    t.string "hotel_id"
    t.bigint "amenity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_hotels_amenities_on_amenity_id"
    t.index ["hotel_id"], name: "index_hotels_amenities_on_hotel_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "link"
    t.string "description"
    t.integer "image_type"
    t.string "hotel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
