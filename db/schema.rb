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

ActiveRecord::Schema.define(version: 20160726223135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "user_id"
    t.integer  "tipo"
    t.integer  "limite_grp_1"
    t.decimal  "valor_1"
    t.integer  "limite_grp_2"
    t.decimal  "valor_2"
    t.integer  "limite_grp_3"
    t.decimal  "valor_3"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "periodo"
  end

  add_index "bills", ["school_id"], name: "index_bills_on_school_id", using: :btree
  add_index "bills", ["user_id", "school_id"], name: "index_bills_on_user_id_and_school_id", using: :btree

  create_table "children", force: :cascade do |t|
    t.integer  "family_id"
    t.string   "nombre",        limit: 255
    t.integer  "grado"
    t.string   "division",      limit: 255
    t.integer  "tipo_servicio"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "children", ["family_id"], name: "index_children_on_family_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "message"
    t.integer  "family_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["family_id"], name: "index_comments_on_family_id", using: :btree
  add_index "comments", ["user_id", "family_id"], name: "index_comments_on_user_id_and_family_id", using: :btree

  create_table "evolutions", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "evolutions", ["school_id"], name: "index_evolutions_on_school_id", using: :btree

  create_table "families", force: :cascade do |t|
    t.string   "apellido",   limit: 255
    t.string   "contacto_1", limit: 255
    t.string   "contacto_2", limit: 255
    t.string   "tel_cel",    limit: 255
    t.string   "tel_casa",   limit: 255
    t.string   "tel_alt",    limit: 255
    t.string   "email",      limit: 255
    t.string   "direccion",  limit: 255
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "activo",                 default: true
  end

  add_index "families", ["school_id"], name: "index_families_on_school_id", using: :btree
  add_index "families", ["user_id"], name: "index_families_on_user_id", using: :btree

  create_table "foods", force: :cascade do |t|
    t.integer  "tipo"
    t.string   "comida",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foods", ["tipo"], name: "index_foods_on_tipo", using: :btree

  create_table "menu_days", force: :cascade do |t|
    t.integer  "bill_id"
    t.integer  "child_id"
    t.integer  "cantidad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "menu_days", ["bill_id"], name: "index_menu_days_on_bill_id", using: :btree
  add_index "menu_days", ["child_id"], name: "index_menu_days_on_child_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "food_id"
    t.date     "fecha"
    t.integer  "orden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "menus", ["fecha"], name: "index_menus_on_fecha", using: :btree
  add_index "menus", ["food_id"], name: "index_menus_on_food_id", using: :btree
  add_index "menus", ["school_id", "fecha"], name: "index_menus_on_school_id_and_fecha", using: :btree
  add_index "menus", ["school_id"], name: "index_menus_on_school_id", using: :btree
  add_index "menus", ["user_id"], name: "index_menus_on_user_id", using: :btree

  create_table "menus_foods", id: false, force: :cascade do |t|
    t.integer "menu_id"
    t.integer "food_id"
  end

  add_index "menus_foods", ["menu_id"], name: "index_menus_foods_on_menu_id", using: :btree

  create_table "movements", force: :cascade do |t|
    t.integer  "family_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo"
    t.decimal  "monto",      precision: 8, scale: 2, default: 0.0
    t.integer  "forma"
    t.decimal  "descuento",  precision: 8, scale: 2, default: 0.0
    t.text     "nota"
    t.integer  "bill_id"
    t.integer  "school_id"
  end

  add_index "movements", ["bill_id"], name: "index_movements_on_bill_id", using: :btree
  add_index "movements", ["family_id"], name: "index_movements_on_family_id", using: :btree
  add_index "movements", ["school_id"], name: "index_movements_on_school_id", using: :btree
  add_index "movements", ["user_id", "family_id"], name: "index_movements_on_user_id_and_family_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["name"], name: "index_schools_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "firstname",              limit: 255
    t.string   "lastname",               limit: 255
    t.boolean  "admin",                              default: false
    t.string   "email",                  limit: 255, default: "",    null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
