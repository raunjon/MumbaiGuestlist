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

ActiveRecord::Schema.define(version: 20160319125856) do

  create_table "clubs", force: :cascade do |t|
    t.string "title"
  end

  create_table "guestlists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "club_id"
    t.string  "mobile"
    t.integer "couples"
    t.date    "entry_date"
    t.integer "status",     default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string  "email"
    t.string  "username"
    t.string  "password_digest"
    t.boolean "admin",           default: false
    t.string  "provider"
    t.string  "uid"
    t.string  "name"
  end

end