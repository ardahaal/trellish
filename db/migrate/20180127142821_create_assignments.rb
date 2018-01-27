class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.timestamps null: false
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
