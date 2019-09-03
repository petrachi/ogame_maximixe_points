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

ActiveRecord::Schema.define(version: 20190824194957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blueprints", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buildings", force: :cascade do |t|
    t.integer "level", default: 0
    t.bigint "planet_id"
    t.bigint "blueprint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_buildings_on_blueprint_id"
    t.index ["planet_id"], name: "index_buildings_on_planet_id"
  end

  create_table "effects", force: :cascade do |t|
    t.string "ressource"
    t.string "effect"
    t.string "quantity"
    t.bigint "blueprint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_effects_on_blueprint_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.integer "temperature"
    t.integer "size"
    t.integer "metal", default: 0
    t.integer "cristal", default: 0
    t.integer "deuterium", default: 0
    t.datetime "last_production", default: "2019-09-02 20:01:05"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_planets_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "researches", force: :cascade do |t|
    t.integer "level"
    t.bigint "player_id"
    t.bigint "blueprint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blueprint_id"], name: "index_researches_on_blueprint_id"
    t.index ["player_id"], name: "index_researches_on_player_id"
  end

  add_foreign_key "buildings", "blueprints"
  add_foreign_key "buildings", "planets"
  add_foreign_key "effects", "blueprints"
  add_foreign_key "researches", "blueprints"
  add_foreign_key "researches", "players"
end
