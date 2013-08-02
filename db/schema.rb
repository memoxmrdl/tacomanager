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

ActiveRecord::Schema.define(version: 20130802152652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizations", force: true do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "establishment_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["establishment_id"], name: "index_comments_on_establishment_id", using: :btree

  create_table "establishments", force: true do |t|
    t.string   "name",        null: false
    t.string   "telephones",  null: false
    t.string   "address",     null: false
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "establishments", ["user_id"], name: "index_establishments_on_user_id", using: :btree

  create_table "foods", force: true do |t|
    t.integer  "establishment_id"
    t.string   "name",             null: false
    t.text     "description",      null: false
    t.float    "price",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foods", ["establishment_id"], name: "index_foods_on_establishment_id", using: :btree

  create_table "images", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "establishment_id"
    t.integer  "food_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["establishment_id"], name: "index_images_on_establishment_id", using: :btree
  add_index "images", ["food_id"], name: "index_images_on_food_id", using: :btree
  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "orderfoods", force: true do |t|
    t.integer  "order_id"
    t.integer  "food_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orderfoods", ["food_id"], name: "index_orderfoods_on_food_id", using: :btree
  add_index "orderfoods", ["order_id"], name: "index_orderfoods_on_order_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "orderfood_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "nickname",                   null: false
    t.string   "email",                      null: false
    t.boolean  "blocked",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
