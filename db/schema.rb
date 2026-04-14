# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_14_162000) do
  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.text "key_topics"
    t.string "level"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer "age"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "engagement_score"
    t.text "goals"
    t.datetime "last_active_at"
    t.string "learning_style"
    t.string "major"
    t.string "name"
    t.text "previous_courses"
    t.text "profile_summary"
    t.integer "progress"
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_students_on_course_id"
  end

  add_foreign_key "students", "courses"
end
