# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_06_052730) do

  create_table "currencies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.timestamp "paid_time"
    t.bigint "request_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["request_id"], name: "index_histories_on_request_id"
  end

  create_table "incomes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.float "amount"
    t.string "currency"
    t.integer "status"
    t.bigint "user_id", null: false
    t.bigint "supplier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_incomes_on_supplier_id"
    t.index ["user_id", "created_at"], name: "index_incomes_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "viewed"
    t.string "item_type"
    t.bigint "item_id"
    t.index ["item_type", "item_id"], name: "index_notifications_on_item_type_and_item_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "request_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.float "amount"
    t.string "description"
    t.string "section_name"
    t.bigint "request_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["request_id"], name: "index_request_details_on_request_id"
  end

  create_table "requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "title"
    t.string "currency"
    t.text "content"
    t.text "reason"
    t.integer "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_requests_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "sections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "suppliers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "taxNum"
    t.string "address"
    t.boolean "sup_type"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_suppliers_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.integer "role"
    t.bigint "section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["section_id"], name: "index_users_on_section_id"
  end

  add_foreign_key "histories", "requests"
  add_foreign_key "incomes", "suppliers"
  add_foreign_key "incomes", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "request_details", "requests"
  add_foreign_key "requests", "users"
  add_foreign_key "suppliers", "users"
  add_foreign_key "users", "sections"
end
