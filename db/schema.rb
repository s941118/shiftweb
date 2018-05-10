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

ActiveRecord::Schema.define(version: 2018_05_10_191238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "contents", force: :cascade do |t|
    t.text "html"
    t.text "processed_html"
    t.bigint "work_id"
    t.integer "ordering"
    t.string "wrapper_klass"
    t.integer "usage", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_id"], name: "index_contents_on_work_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "job_title"
    t.string "join_time"
    t.integer "works_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "work_tags", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_work_tags_on_tag_id"
    t.index ["work_id"], name: "index_work_tags_on_work_id"
  end

  create_table "works", force: :cascade do |t|
    t.string "number"
    t.string "title"
    t.string "category"
    t.string "top_tags"
    t.date "work_date"
    t.integer "tags_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "outline"
  end

  add_foreign_key "contents", "works"
  add_foreign_key "work_tags", "tags"
  add_foreign_key "work_tags", "works"
end
