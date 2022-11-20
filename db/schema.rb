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

ActiveRecord::Schema[7.0].define(version: 2022_11_20_111755) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_registrations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_registrations_on_course_id"
    t.index ["user_id", "course_id"], name: "index_course_registrations_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_course_registrations_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "full_name"
    t.text "description"
    t.string "course_type"
    t.float "price"
    t.integer "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "room_registrations", force: :cascade do |t|
    t.bigint "term_id"
    t.bigint "room_id"
    t.date "date"
    t.time "time_start"
    t.time "time_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_registrations_on_room_id"
    t.index ["term_id"], name: "index_room_registrations_on_term_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "term_registrations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "term_id"
    t.float "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["term_id"], name: "index_term_registrations_on_term_id"
    t.index ["user_id", "term_id"], name: "index_term_registrations_on_user_id_and_term_id", unique: true
    t.index ["user_id"], name: "index_term_registrations_on_user_id"
  end

  create_table "terms", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.string "name"
    t.string "term_type"
    t.date "date"
    t.time "time_start"
    t.time "time_end"
    t.integer "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_terms_on_course_id"
    t.index ["user_id"], name: "index_terms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "surname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
