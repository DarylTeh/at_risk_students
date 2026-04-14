class AddProfileFieldsToStudents < ActiveRecord::Migration[8.1]
  def change
    add_column :students, :age, :integer
    add_column :students, :major, :string
    add_column :students, :profile_summary, :text
    add_column :students, :previous_courses, :text
    add_column :students, :learning_style, :string
    add_column :students, :goals, :text
  end
end
