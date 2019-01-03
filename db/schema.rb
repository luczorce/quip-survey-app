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

ActiveRecord::Schema.define(version: 2019_01_03_174130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "input_text_answers", force: :cascade do |t|
    t.string "answer"
    t.string "quip_id"
    t.bigint "input_text_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "answer_type", default: "text_input"
    t.index ["input_text_question_id"], name: "index_input_text_answers_on_input_text_question_id"
  end

  create_table "input_text_questions", force: :cascade do |t|
    t.string "question"
    t.integer "order"
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "question_type", default: "text_input"
    t.index ["survey_id"], name: "index_input_text_questions_on_survey_id"
  end

  create_table "option_answers", force: :cascade do |t|
    t.string "answer", array: true
    t.string "quip_id"
    t.string "answer_type"
    t.bigint "option_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_question_id"], name: "index_option_answers_on_option_question_id"
  end

  create_table "option_questions", force: :cascade do |t|
    t.string "question"
    t.bigint "survey_id"
    t.string "options", array: true
    t.integer "order"
    t.string "question_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_option_questions_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "textarea_answers", force: :cascade do |t|
    t.text "answer"
    t.string "quip_id"
    t.string "answer_type", default: "textarea"
    t.bigint "textarea_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["textarea_question_id"], name: "index_textarea_answers_on_textarea_question_id"
  end

  create_table "textarea_questions", force: :cascade do |t|
    t.string "question"
    t.integer "order"
    t.string "question_type", default: "textarea"
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_textarea_questions_on_survey_id"
  end

  add_foreign_key "input_text_answers", "input_text_questions"
  add_foreign_key "input_text_questions", "surveys"
  add_foreign_key "option_answers", "option_questions"
  add_foreign_key "option_questions", "surveys"
  add_foreign_key "textarea_answers", "textarea_questions"
  add_foreign_key "textarea_questions", "surveys"
end
