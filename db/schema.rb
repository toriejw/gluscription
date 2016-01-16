# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160116034920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "search_results", force: :cascade do |t|
    t.string   "medication"
    t.string   "gluten_free_status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
  end

  add_index "search_results", ["user_id"], name: "index_search_results_on_user_id", using: :btree

  create_table "suspect_ingredients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "search_result_id"
  end

  add_index "suspect_ingredients", ["search_result_id"], name: "index_suspect_ingredients_on_search_result_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "third_party_id"
  end

  add_foreign_key "search_results", "users"
  add_foreign_key "suspect_ingredients", "search_results"
end
