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

ActiveRecord::Schema.define(version: 20170609172833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bebidas", force: :cascade do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.string   "tamanio"
    t.decimal  "precio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "empresas", force: :cascade do |t|
    t.bigint   "rut"
    t.string   "nombre"
    t.string   "razon_social"
    t.bigint   "telefono"
    t.string   "direccion"
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "franjas", force: :cascade do |t|
    t.datetime "fecha"
    t.decimal  "primera_hasta"
    t.decimal  "primera_precio"
    t.decimal  "segunda_hasta"
    t.decimal  "segunda_precio"
    t.decimal  "tercera_precio"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "fringes", force: :cascade do |t|
    t.datetime "fecha"
    t.decimal  "primera_hasta"
    t.decimal  "primera_precio"
    t.decimal  "segunda_hasta"
    t.decimal  "segunda_precio"
    t.decimal  "tercera_precio"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "menus", force: :cascade do |t|
    t.date     "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fecha"], name: "index_menus_on_fecha", unique: true, using: :btree
  end

  create_table "productos", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "tipo_id"
    t.decimal  "precio"
    t.index ["tipo_id"], name: "index_productos_on_tipo_id", using: :btree
  end

  create_table "tiene_productos", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "producto_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["menu_id"], name: "index_tiene_productos_on_menu_id", using: :btree
    t.index ["producto_id"], name: "index_tiene_productos_on_producto_id", using: :btree
  end

  create_table "tipos", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "ci"
    t.string   "nombres"
    t.string   "apellidos"
    t.string   "rol"
    t.boolean  "habilitado"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "productos", "tipos"
  add_foreign_key "tiene_productos", "menus"
  add_foreign_key "tiene_productos", "productos"
end