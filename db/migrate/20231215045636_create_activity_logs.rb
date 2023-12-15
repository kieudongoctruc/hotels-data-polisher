class CreateActivityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_logs do |t|
      t.string :name
      t.jsonb :log
      t.string :from
      
      t.timestamps
    end
  end
end
