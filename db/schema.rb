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

ActiveRecord::Schema.define(version: 20130730042444) do

  create_table "establishments", force: true do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.string   "location",    null: false
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", force: true do |t|
    t.string   "name",             null: false
    t.text     "description",      null: false
    t.float    "price",            null: false
    t.integer  "establishment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foods", ["establishment_id"], name: "index_foods_on_establishment_id", using: :btree

  create_table "identities", force: true do |t|
    t.string   "provider",                   null: false
    t.string   "uid",                        null: false
    t.string   "username",                   null: false
    t.string   "email"
    t.boolean  "blocked",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
