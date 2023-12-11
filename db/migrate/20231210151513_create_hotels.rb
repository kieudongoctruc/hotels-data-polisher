class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels, id: false do |t|
      t.string :id, null: false
      t.integer :destination_id, null: false
      t.string :name, null: false
      t.text :description
      t.text :details
      t.text :info
      t.text :booking_conditions, array: true
      t.float :lat
      t.float :long
      t.string :address
      t.string :city
      t.integer :country_id, null: false

      t.timestamps
      t.index ["name"], name: "index_hotels_on_name"
      t.index ["id"], name: "index_hotels_on_id"
    end
  end
end
