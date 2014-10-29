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

ActiveRecord::Schema.define(version: 20141027195253) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: true do |t|
    t.string   "zipcode"
    t.string   "city"
    t.string   "town"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "municipality_id"
    t.boolean  "available",       default: false, null: false
  end

  add_index "areas", ["municipality_id"], name: "index_areas_on_municipality_id", using: :btree
  add_index "areas", ["zipcode"], name: "index_areas_on_zipcode", unique: true, using: :btree

  create_table "calculations", force: true do |t|
    t.integer  "area_id"
    t.integer  "basic"
    t.integer  "advanced"
    t.integer  "professional"
    t.integer  "other_category"
    t.integer  "engel"
    t.integer  "male"
    t.integer  "femail"
    t.integer  "enterprise"
    t.integer  "unknown"
    t.integer  "consumer"
    t.integer  "age_0"
    t.integer  "age_1"
    t.integer  "age_2"
    t.integer  "age_3"
    t.integer  "age_4"
    t.integer  "age_5"
    t.integer  "age_6"
    t.integer  "age_u"
    t.integer  "young"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calculations", ["area_id"], name: "index_calculations_on_area_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "municipalities", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "municipalities", ["key"], name: "index_municipalities_on_key", unique: true, using: :btree

  create_table "subcategories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "tag"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcategories", ["name"], name: "index_subcategories_on_name", unique: true, using: :btree

end
