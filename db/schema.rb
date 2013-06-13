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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130613082935) do

  create_table "companies", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "contact"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "password_digest"
    t.string   "remember_company"
  end

  add_index "companies", ["email"], :name => "index_companies_on_email", :unique => true
  add_index "companies", ["remember_company"], :name => "index_companies_on_remember_company"
  add_index "companies", ["username"], :name => "index_companies_on_username", :unique => true

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "mobile_number"
    t.string   "email"
    t.string   "division"
    t.boolean  "role"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.integer  "office_id"
  end

  add_index "employees", ["email"], :name => "index_employees_on_email", :unique => true
  add_index "employees", ["mobile_number"], :name => "index_employees_on_mobile_number", :unique => true

  create_table "offices", :force => true do |t|
    t.string   "name"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "company_id"
  end

  create_table "worktimes", :force => true do |t|
    t.integer  "employee_id"
    t.datetime "checkin"
    t.datetime "checkout"
    t.string   "place_checkin"
    t.string   "place_checkout"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
