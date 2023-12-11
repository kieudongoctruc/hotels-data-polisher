class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.string :link
      t.string :description
      t.integer :image_type
      t.string :hotel_id

      t.timestamps
    end
  end
end
