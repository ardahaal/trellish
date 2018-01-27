class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.timestamps null: false
      t.string :title, null: false
      t.text :description, null: false
      t.references :list, foreign_key: true
    end
  end
end
