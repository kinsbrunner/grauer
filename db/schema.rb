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

ActiveRecord::Schema.define(version: 20160604234725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "children", force: true do |t|
    t.integer  "family_id"
    t.string   "nombre"
    t.integer  "grado"
    t.integer  "division"
    t.integer  "tipo_servicio"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "children", ["family_id"], name: "index_children_on_family_id", using: :btree

  create_table "families", force: true do |t|
    t.string   "apellido"
    t.string   "contacto_1"
    t.string   "contacto_2"
    t.string   "tel_cel"
    t.string   "tel_casa"
    t.string   "tel_alt"
    t.string   "email"
    t.string   "direccion"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "families", ["school_id"], name: "index_families_on_school_id", using: :btree
  add_index "families", ["user_id"], name: "index_families_on_user_id", using: :btree

  create_table "schools", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["name"], name: "index_schools_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "admin",                  default: false
    t.string   "email",                  default: "",    null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
