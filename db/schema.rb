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

ActiveRecord::Schema.define(version: 2018_08_02_080726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "text"
    t.string "attachable_type"
    t.bigint "attachable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "title", null: false
    t.text "text"
    t.datetime "due_date"
    t.bigint "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_cards_on_list_id"
  end

  create_table "cards_labels", id: false, force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "label_id", null: false
  end

  create_table "cards_users", id: false, force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "text"
    t.bigint "card_id", null: false
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_comments_on_card_id"
    t.index ["owner_id"], name: "index_comments_on_owner_id"
  end

  create_table "dashboards", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "public", null: false
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_dashboards_on_owner_id"
  end

  create_table "dashboards_users", id: false, force: :cascade do |t|
    t.bigint "dashboard_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.integer "color", default: 0, null: false
    t.bigint "dashboard_id"
    t.index ["dashboard_id"], name: "index_labels_on_dashboard_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "dashboard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_lists_on_dashboard_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "lists"
  add_foreign_key "comments", "cards"
  add_foreign_key "comments", "users", column: "owner_id"
  add_foreign_key "dashboards", "users", column: "owner_id"
  add_foreign_key "labels", "dashboards"
  add_foreign_key "lists", "dashboards"
end
