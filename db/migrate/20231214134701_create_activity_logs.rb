class CreateActivityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_logs do |t|
      t.string :supplier
      t.string :activity_name
      t.text :message
      
      t.timestamps
    end
  end
end
