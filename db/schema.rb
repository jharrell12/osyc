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

ActiveRecord::Schema[7.1].define(version: 2024_03_24_213454) do
  create_table "addresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "label"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.index ["person_id"], name: "index_addresses_on_person_id"
  end

  create_table "charges", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invoice_id", null: false
    t.string "description"
    t.integer "price"
    t.index ["invoice_id"], name: "index_charges_on_invoice_id"
  end

  create_table "emails", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "label"
    t.string "address"
    t.index ["person_id"], name: "index_emails_on_person_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "membership_id", null: false
    t.string "status"
    t.datetime "posted_date"
    t.date "due_date"
    t.integer "balance_due"
    t.index ["membership_id"], name: "index_invoices_on_membership_id"
  end

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

  create_table "payments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invoice_id", null: false
    t.date "date"
    t.integer "amount"
    t.string "check_number"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
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

  create_table "phones", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "label"
    t.string "number"
    t.index ["person_id"], name: "index_phones_on_person_id"
  end

  add_foreign_key "addresses", "people"
  add_foreign_key "charges", "invoices"
  add_foreign_key "emails", "people"
  add_foreign_key "invoices", "memberships"
  add_foreign_key "payments", "invoices"
  add_foreign_key "people", "memberships"
  add_foreign_key "phones", "people"
end
