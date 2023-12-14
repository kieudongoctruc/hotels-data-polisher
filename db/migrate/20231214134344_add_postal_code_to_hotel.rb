class AddPostalCodeToHotel < ActiveRecord::Migration[7.1]
  def change
    add_column :hotels, :postal_code, :integer
  end
end
