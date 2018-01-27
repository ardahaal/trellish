class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.timestamps null: false
      t.string :name, limit: 100, null: false
      t.integer :status, null: false, default: 0
    end
  end
end
