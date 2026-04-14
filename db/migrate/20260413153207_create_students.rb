class CreateStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :students do |t|
      t.string :name
      t.references :course, null: false, foreign_key: true
      t.datetime :last_active_at
      t.integer :progress
      t.integer :engagement_score

      t.timestamps
    end
  end
end
