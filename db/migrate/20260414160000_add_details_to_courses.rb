class AddDetailsToCourses < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :description, :text
    add_column :courses, :level, :string
    add_column :courses, :key_topics, :text
  end
end
