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

ActiveRecord::Schema.define(:version => 20121122031901) do

  create_table "entries", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.integer  "subnet_id",                       :null => false
    t.string   "server_name",                     :null => false
    t.string   "model",                           :null => false
    t.string   "operating_system", :limit => 100, :null => false
    t.string   "serial_number",                   :null => false
    t.string   "ip",               :limit => 15,  :null => false
    t.date     "warranty"
    t.string   "public_ip",        :limit => 15
    t.string   "location",         :limit => 200
    t.string   "segment",          :limit => 100
    t.string   "application",      :limit => 100
    t.string   "username"
    t.string   "password"
    t.text     "remarks"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "entries_tags", :id => false, :force => true do |t|
    t.integer "entry_id"
    t.integer "tag_id"
  end

  add_index "entries_tags", ["entry_id", "tag_id"], :name => "index_entries_tags_on_entry_id_and_tag_id"

  create_table "subnets", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.string   "name",        :limit => 100, :null => false
    t.string   "cidr",        :limit => 20,  :null => false
    t.string   "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                     :null => false
    t.string   "password",                                     :null => false
    t.boolean  "editor",                    :default => false
    t.boolean  "viewer",                    :default => true
    t.string   "name",       :limit => 200
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "salt",       :limit => 100,                    :null => false
  end

end
