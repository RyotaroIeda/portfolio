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

ActiveRecord::Schema.define(version: 2022_12_20_132014) do

  create_table "favorites", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "sauna_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sauna_id"], name: "index_favorites_on_sauna_id"
    t.index ["user_id", "sauna_id"], name: "index_favorites_on_user_id_and_sauna_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "saunas", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.string "image_id"
    t.integer "water_temperature"
    t.time "open_time"
    t.time "close_time"
    t.integer "sauna_temperature"
    t.integer "sauna_capacity"
    t.integer "water_capacity"
    t.text "sauna_body"
    t.text "water_body"
    t.boolean "louly_aufgoose", default: false, null: false
    t.text "louly_body"
    t.boolean "rest_space", default: false, null: false
    t.text "rest_body"
    t.string "address"
    t.text "access"
    t.string "tel"
    t.string "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile_image_id"
    t.text "introduce"
    t.string "homesauna"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favorites", "saunas"
  add_foreign_key "favorites", "users"
end
