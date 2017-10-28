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

ActiveRecord::Schema.define(version: 20151031060139) do

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "languages", ["name"], name: "index_languages_on_name", unique: true

  create_table "readmes", force: :cascade do |t|
    t.text     "original"
    t.text     "raw_html"
    t.integer  "repository_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "file_name"
  end

  add_index "readmes", ["repository_id"], name: "index_readmes_on_repository_id", unique: true

  create_table "repositories", force: :cascade do |t|
    t.string   "repository_id"
    t.string   "name"
    t.string   "full_name"
    t.string   "html_url"
    t.string   "description"
    t.string   "url"
    t.datetime "publish_at"
    t.string   "git_url"
    t.string   "homepage"
    t.integer  "size"
    t.integer  "stargazers_count"
    t.integer  "watchers_count"
    t.integer  "forks_count"
    t.integer  "language_id"
    t.string   "default_branch"
    t.integer  "process_state"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.datetime "last_sync_readme_time"
  end

  add_index "repositories", ["language_id"], name: "index_repositories_on_language_id"
  add_index "repositories", ["repository_id"], name: "index_repositories_on_repository_id", unique: true

end
