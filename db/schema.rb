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

ActiveRecord::Schema.define(version: 20130813171104) do

  create_table "addresses", force: true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip_code"
    t.integer  "establishment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "addresses", ["establishment_id"], name: "index_addresses_on_establishment_id", using: :btree

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
    t.text     "comment",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["establishment_id"], name: "index_comments_on_establishment_id", using: :btree

  create_table "establishments", force: true do |t|
    t.string   "name",       null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "schedule"
    t.string   "phone"
  end

  add_index "establishments", ["user_id"], name: "index_establishments_on_user_id", using: :btree

  create_table "foods", force: true do |t|
    t.string   "name",             null: false
    t.text     "description"
    t.float    "price",            null: false
    t.integer  "establishment_id"
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

  create_table "order_details", force: true do |t|
    t.integer  "quantity"
    t.float    "subtotal"
    t.integer  "order_id"
    t.integer  "user_id"
    t.integer  "food_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "payment",    default: false
  end

  add_index "order_details", ["food_id"], name: "index_order_details_on_food_id", using: :btree
  add_index "order_details", ["order_id"], name: "index_order_details_on_order_id", using: :btree
  add_index "order_details", ["user_id"], name: "index_order_details_on_user_id", using: :btree

  create_table "orders", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "establishment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.boolean  "payment"
    t.integer  "user_id_payment"
  end

  add_index "orders", ["establishment_id"], name: "index_orders_on_establishment_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "nickname",                   null: false
    t.string   "email",                      null: false
    t.boolean  "admin",      default: false
    t.boolean  "blocked",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
