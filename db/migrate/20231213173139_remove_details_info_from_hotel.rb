class RemoveDetailsInfoFromHotel < ActiveRecord::Migration[7.1]
  def change
    remove_column :hotels, :details
    remove_column :hotels, :info
  end
end
