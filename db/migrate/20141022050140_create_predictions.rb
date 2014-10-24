class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.integer :user_id, null: false
      t.date :date, null: false
      t.timestamps
    end
  end
end
