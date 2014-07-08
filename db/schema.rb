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

ActiveRecord::Schema.define(:version => 20140708165457) do

  create_table "batting_stats", :force => true do |t|
    t.integer  "player_id"
    t.string   "legacy_id"
    t.integer  "at_bats"
    t.integer  "hits"
    t.integer  "doubles"
    t.integer  "triples"
    t.integer  "home_runs"
    t.integer  "runs_batted"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.integer  "batting_year"
    t.integer  "league_id"
    t.decimal  "batting_average",            :precision => 3, :scale => 2
    t.decimal  "slugging_percentage",        :precision => 3, :scale => 2
    t.integer  "team_id"
    t.decimal  "batting_average_change",     :precision => 3, :scale => 2
    t.decimal  "batting_average_difference", :precision => 3, :scale => 2
  end

  create_table "batting_stats_import", :id => false, :force => true do |t|
    t.string  "player_id", :limit => 20
    t.string  "yearid",    :limit => 10
    t.string  "league",    :limit => 10
    t.string  "teamid",    :limit => 20
    t.string  "g",         :limit => 20
    t.string  "ab",        :limit => 20
    t.string  "r",         :limit => 20
    t.string  "h",         :limit => 20
    t.string  "twob",      :limit => 20
    t.string  "threeb",    :limit => 20
    t.string  "hr",        :limit => 20
    t.string  "rbi",       :limit => 20
    t.string  "sb",        :limit => 20
    t.string  "cs",        :limit => 20
    t.integer "league_id", :limit => 2
  end

  create_table "leagues", :force => true do |t|
    t.string   "league_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "photo_name"
    t.string   "file_name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "player_awards", :force => true do |t|
    t.integer  "league_id"
    t.string   "award_year"
    t.string   "award_name"
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "players", :force => true do |t|
    t.integer  "team_id"
    t.string   "legacy_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
  end

  create_table "players_import", :id => false, :force => true do |t|
    t.string  "legacy_id", :limit => 20
    t.string  "birthyear", :limit => 10
    t.string  "namefirst", :limit => 20
    t.string  "namelast",  :limit => 30
    t.integer "player_id", :limit => 2
  end

  create_table "teams", :force => true do |t|
    t.integer  "league_id"
    t.string   "team_name"
    t.string   "owner_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "notes"
  end

  create_table "testdbs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
