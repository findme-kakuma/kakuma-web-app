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

ActiveRecord::Schema.define(version: 20160406154255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "country_translations", force: :cascade do |t|
    t.integer  "country_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "country_translations", ["country_id"], name: "index_country_translations_on_country_id", using: :btree
  add_index "country_translations", ["locale"], name: "index_country_translations_on_locale", using: :btree

  create_table "residents", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "country_id"
    t.string   "place"
    t.string   "father_name"
    t.string   "grandfather_name"
  end

  add_index "residents", ["country_id"], name: "index_residents_on_country_id", using: :btree

  add_foreign_key "residents", "countries"
end
