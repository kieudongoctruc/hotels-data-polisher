class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels, id: false do |t|
      t.string :id, null: false
      t.integer :destination_id, null: false
      t.string :name
      t.text :description
      t.text :details
      t.text :info
      t.text :booking_conditions, array: true
      t.float :lat
      t.float :lng
      t.string :address
      t.string :city
      t.integer :country_id

      t.timestamps

      t.index ["id"], name: "index_hotels_on_id"
      t.index ["destination_id"], name: "index_hotels_on_destination_id"
    end
  end
end
