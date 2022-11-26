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

ActiveRecord::Schema[7.0].define(version: 2022_11_25_225619) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "cep"
    t.string "complement"
    t.string "street"
    t.string "neighborhood"
    t.string "city"
    t.string "uf"
    t.string "ibge_code"
    t.bigint "county_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["county_id"], name: "index_addresses_on_county_id"
  end

  create_table "counties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "user_counties", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "county_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["county_id"], name: "index_user_counties_on_county_id"
    t.index ["user_id"], name: "index_user_counties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.string "cns"
    t.string "email"
    t.date "birth_date"
    t.string "phone"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "counties"
  add_foreign_key "user_counties", "counties"
  add_foreign_key "user_counties", "users"
end
