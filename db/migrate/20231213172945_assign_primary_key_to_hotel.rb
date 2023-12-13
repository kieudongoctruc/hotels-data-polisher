class AssignPrimaryKeyToHotel < ActiveRecord::Migration[7.1]
  def change
    execute "ALTER TABLE hotels ADD PRIMARY KEY (id);"
  end
end
