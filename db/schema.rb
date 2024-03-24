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

ActiveRecord::Schema[7.1].define(version: 2024_03_24_210243) do
  create_table "memberships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.string "boats"
    t.string "slip_assignment"
    t.string "children"
  end

  create_table "people", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "membership_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.integer "birth_year"
    t.index ["membership_id"], name: "index_people_on_membership_id"
  end

  create_table "test_table", force: :cascade do |t|
    t.string "field_1", limit: 40
    t.string "field_2", limit: 40
  end

  add_foreign_key "people", "memberships"
end
