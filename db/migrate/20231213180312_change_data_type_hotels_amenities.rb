class ChangeDataTypeHotelsAmenities < ActiveRecord::Migration[7.1]
  def change
    change_column(:hotels_amenities, :hotel_id, :string)
  end
end
