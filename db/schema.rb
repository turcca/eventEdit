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

ActiveRecord::Schema.define(version: 20140614114510) do

  create_table "advice_contents", force: true do |t|
    t.string   "type"
    t.string   "condition"
    t.integer  "tool_id"
    t.string   "equality"
    t.string   "value"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
    t.integer  "captain_id"
    t.integer  "navigator_id"
    t.integer  "engineer_id"
    t.integer  "quartermaster_id"
    t.integer  "security_id"
    t.integer  "priest_id"
    t.integer  "psycher_id"
    t.integer  "content_choice_id"
  end

  create_table "chosen_filters", force: true do |t|
    t.integer  "event_id"
    t.integer  "filter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chosen_outcomes", force: true do |t|
    t.integer  "event_id"
    t.integer  "content_outcome_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chosen_parameters", force: true do |t|
    t.integer  "chosen_tool_id"
    t.integer  "parameter_value_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_value"
    t.integer  "parameter_id"
  end

  create_table "chosen_tools", force: true do |t|
    t.integer  "tool_id"
    t.integer  "pre_tool_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete"
  end

  create_table "contents", force: true do |t|
    t.string   "ancestry"
    t.string   "type"
    t.text     "text"
    t.string   "condition"
    t.integer  "tool1_id"
    t.integer  "skill1_id"
    t.string   "equality1"
    t.string   "andor"
    t.integer  "tool2_id"
    t.integer  "skill2_id"
    t.string   "equality2"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value1"
    t.string   "value2"
    t.string   "rangevalue"
  end

  add_index "contents", ["ancestry"], name: "index_contents_on_ancestry"

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "comment",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "character_tool_id"
    t.string   "frequency",                     default: "Default"
    t.string   "ancestry"
    t.string   "situation",                     default: "Default"
    t.integer  "trigger_tool_id"
    t.string   "ambient",                       default: "DefaultBridge"
    t.integer  "location_tool_id"
    t.string   "filtercolor"
    t.string   "colorfiltername"
  end

  add_index "events", ["ancestry"], name: "index_events_on_ancestry"

  create_table "filters", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "parameter_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_custom_type"
    t.boolean  "needs_quotation"
    t.boolean  "system"
  end

  create_table "parameter_values", force: true do |t|
    t.integer  "parameter_type_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tooltip"
  end

  create_table "parameters", force: true do |t|
    t.integer  "tool_id"
    t.integer  "parameter_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_number"
  end

  create_table "pre_tool_associations", force: true do |t|
    t.integer  "pre_tool_id"
    t.integer  "tool_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "probabilities", force: true do |t|
    t.string   "condition"
    t.integer  "tool1_id",   limit: 255
    t.string   "equality1"
    t.string   "value1",                 default: "0"
    t.string   "andor"
    t.integer  "tool2_id",   limit: 255
    t.string   "equality2"
    t.string   "value2",                 default: "0"
    t.string   "p",                      default: "0"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.string   "rangevalue"
  end

  create_table "secondary_chosen_outcomes", force: true do |t|
    t.integer  "secondary_prereq_id"
    t.integer  "content_outcome_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secondary_prereqs", force: true do |t|
    t.integer  "event_id"
    t.integer  "prereq_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "p"
  end

  create_table "tools", force: true do |t|
    t.string   "name"
    t.string   "tooltype"
    t.boolean  "character"
    t.boolean  "probability"
    t.boolean  "content_condition"
    t.boolean  "content_effect"
    t.boolean  "is_pre_tool"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tooltip"
    t.boolean  "trigger"
    t.boolean  "system"
    t.boolean  "location"
    t.boolean  "advice"
    t.boolean  "booleanreturn"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",               default: false, null: false
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["approved"], name: "index_users_on_approved"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
