# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170810121715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accounts", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.bigint "user_id"
    t.text "uid", default: "", null: false
    t.text "provider", default: "", null: false
    t.text "type", default: "", null: false
    t.json "token", default: {}
    t.json "features", default: {}
    t.json "metadata", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["provider"], name: "accounts_provider_idx"
    t.index ["uid"], name: "accounts_uid_unq_idx", unique: true
    t.index ["user_id"], name: "accounts_users_id_unq_idx", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.text "name", default: "", null: false
    t.text "email", default: "", null: false
    t.text "username", default: "", null: false
    t.text "password", default: "", null: false
    t.json "features", default: {}
    t.json "metadata", default: {}
    t.bigint "sign_in_count", default: 0, null: false
    t.datetime "remember_created_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["username"], name: "users_username_idx", unique: true
  end

  add_foreign_key "accounts", "users", name: "accounts_user_id_fk"
end
