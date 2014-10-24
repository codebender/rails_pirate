class CreateStatData < ActiveRecord::Migration
  def change
    create_table :stat_data do |t|
      t.integer  :user_id, null: false
      t.datetime :start_time, null: false
      t.integer  :value, null: false
      t.timestamps
    end

    add_index :stat_data, :user_id
  end
end
