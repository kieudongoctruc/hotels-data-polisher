class CreateHotelsAmenities < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels_amenities do |t|
      t.belongs_to :hotel
      t.belongs_to :amenity

      t.timestamps
    end
  end
end
