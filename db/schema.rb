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

ActiveRecord::Schema.define(version: 20150922032855) do

  create_table "beers", force: :cascade do |t|
    t.string   "name"
    t.string   "style"
    t.string   "brewery"
    t.string   "brewery_url"
    t.text     "description"
    t.decimal  "alcohol"
    t.string   "picture"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "drunk_on"
  end

  add_index "beers", ["name"], name: "index_beers_on_name", unique: true

  create_table "beers_meetings", id: false, force: :cascade do |t|
    t.integer "beer_id"
    t.integer "meeting_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.date     "date"
    t.text     "comments"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "meeting_background"
  end

  create_table "meetings_users", id: false, force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "beer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "postcode"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "favourite"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
