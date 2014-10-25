class CreatePredicitionData < ActiveRecord::Migration
  def change
    create_table :prediction_data do |t|
      t.integer  :user_id, null: false
      t.datetime :start_time, null: false
      t.integer  :value, null: false
      t.timestamps
    end

    add_index :prediction_data, :user_id
  end
end
