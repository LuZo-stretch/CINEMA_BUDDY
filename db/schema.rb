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

ActiveRecord::Schema[7.1].define(version: 2024_03_03_051135) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_chats_on_match_id"
  end

  create_table "cinema_shows", force: :cascade do |t|
    t.bigint "cinema_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cinema_id"], name: "index_cinema_shows_on_cinema_id"
    t.index ["movie_id"], name: "index_cinema_shows_on_movie_id"
  end

  create_table "cinemas", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "cinema_url"
    t.integer "rating"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "liked_movies", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_liked_movies_on_movie_id"
    t.index ["user_id"], name: "index_liked_movies_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "user_match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_matches_on_user_id"
    t.index ["user_match_id"], name: "index_matches_on_user_match_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "timestamp", precision: nil
    t.bigint "chat_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.text "synopsis"
    t.integer "rating"
    t.string "trailer"
    t.date "end_date"
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chats", "matches"
  add_foreign_key "cinema_shows", "cinemas"
  add_foreign_key "cinema_shows", "movies"
  add_foreign_key "liked_movies", "movies"
  add_foreign_key "liked_movies", "users"
  add_foreign_key "matches", "users"
  add_foreign_key "matches", "users", column: "user_match_id"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
end
