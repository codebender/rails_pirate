class AddPredicitionId < ActiveRecord::Migration
  def change
    add_column :prediction_data, :prediction_id, :integer, null: false

    add_index :prediction_data, :prediction_id
  end
end
