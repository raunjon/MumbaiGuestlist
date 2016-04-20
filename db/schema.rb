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

ActiveRecord::Schema.define(version: 20160418072759) do

  create_table "clubs", force: :cascade do |t|
    t.string  "title"
    t.boolean "enabled",     default: true
    t.string  "description"
    t.string  "address"
    t.float   "latitude"
    t.float   "longitude"
    t.string  "club_policy"
  end

  create_table "feeds", force: :cascade do |t|
    t.string  "twitter_id"
    t.string  "twitter_handle"
    t.string  "instagram_id"
    t.string  "instagram_handle"
    t.string  "instagram_location"
    t.integer "club_id"
    t.string  "hashtag"
  end

  create_table "guestlists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "club_id"
    t.string  "mobile"
    t.integer "couples"
    t.date    "entry_date"
    t.integer "status",     default: 0
    t.integer "source"
  end

  create_table "logins", force: :cascade do |t|
    t.string   "identification",          null: false
    t.string   "password_digest"
    t.string   "oauth2_token",            null: false
    t.string   "uid"
    t.string   "single_use_oauth2_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
  end

  create_table "sms", force: :cascade do |t|
    t.string "number"
  end

  create_table "users", force: :cascade do |t|
    t.string  "email"
    t.string  "username"
    t.string  "password_digest"
    t.boolean "admin",               default: false
    t.string  "provider"
    t.string  "uid"
    t.string  "name"
    t.boolean "autoaccept",          default: false
    t.string  "mobile"
    t.string  "gender"
    t.string  "push_id"
    t.integer "source",              default: 0
    t.string  "relationship_status"
    t.string  "birthday"
  end

end
