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

ActiveRecord::Schema.define(version: 2019_08_05_050658) do

  create_table "administrators", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.string "value"
    t.string "highlight"
    t.integer "time"
    t.integer "preference"
    t.string "preference_reason"
    t.boolean "finished", default: false
    t.integer "article_id"
    t.integer "task_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_answers_on_article_id"
    t.index ["task_id"], name: "index_answers_on_task_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "topic"
    t.string "subtopic"
    t.string "title"
    t.text "metadata"
    t.text "content"
    t.integer "expert_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.string "side"
    t.string "kind"
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "kind"
    t.string "question"
    t.string "options"
    t.string "highlights"
    t.string "constraints"
    t.decimal "consensus", default: "1.0"
    t.string "gold_task"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.integer "capability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
