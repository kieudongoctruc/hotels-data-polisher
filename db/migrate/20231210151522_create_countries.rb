class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries do |t|
      t.string "name"
      t.string "iso_alpha2_code"

      t.timestamps
    end
  end
end
