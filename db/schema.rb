# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_02_053858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "autosaves", force: :cascade do |t|
    t.binary "title"
    t.binary "content"
    t.binary "title_iv"
    t.binary "content_iv"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.binary "title", null: false
    t.binary "content", null: false
    t.binary "title_iv", null: false
    t.binary "content_iv", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.binary "sharing_token"
    t.binary "sharing_token_iv"
    t.boolean "listed_publicly", default: false, null: false
    t.index ["listed_publicly"], name: "index_posts_on_listed_publicly"
    t.index ["sharing_token"], name: "index_posts_on_sharing_token", unique: true
  end

  create_table "prompts", force: :cascade do |t|
    t.binary "content", null: false
    t.binary "content_iv", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
