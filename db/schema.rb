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

ActiveRecord::Schema.define(version: 20150621184322) do

  create_table "average_caches", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "jmeno"
    t.string   "prijmeni"
    t.string   "adresa"
    t.string   "mesto"
    t.integer  "psc"
    t.integer  "mobcislo"
    t.date     "datumkontaktu"
    t.string   "email"
    t.boolean  "kontaktovan"
    t.boolean  "odpoved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "barva",         null: false
  end

  create_table "customers_dluhs", id: false, force: true do |t|
    t.integer "customer_id"
    t.integer "dluh_id"
  end

  add_index "customers_dluhs", ["customer_id", "dluh_id"], name: "index_customers_dluhs_on_customer_id_and_dluh_id"

  create_table "customers_nakups", id: false, force: true do |t|
    t.integer "customer_id"
    t.integer "nakup_id"
  end

  add_index "customers_nakups", ["customer_id", "nakup_id"], name: "index_customers_nakups_on_customer_id_and_nakup_id"

  create_table "customers_poznamkas", id: false, force: true do |t|
    t.integer "customer_id"
    t.integer "poznamka_id"
  end

  add_index "customers_poznamkas", ["customer_id", "poznamka_id"], name: "index_customers_poznamkas_on_customer_id_and_poznamka_id"

  create_table "customers_ppls", id: false, force: true do |t|
    t.integer "customer_id"
    t.integer "ppl_id"
  end

  add_index "customers_ppls", ["customer_id", "ppl_id"], name: "index_customers_ppls_on_customer_id_and_ppl_id"

  create_table "dluhs", force: true do |t|
    t.float    "dluh"
    t.string   "poznamka"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.integer  "customer_id", null: false
  end

  create_table "nakups", force: true do |t|
    t.float    "cena_nakupu"
    t.date     "datum_nakupu"
    t.boolean  "planovanynakup"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id",    null: false
  end

  create_table "nakups_zbozis", id: false, force: true do |t|
    t.integer "nakup_id"
    t.integer "zbozi_id"
  end

  add_index "nakups_zbozis", ["nakup_id", "zbozi_id"], name: "index_nakups_zbozis_on_nakup_id_and_zbozi_id"

  create_table "poznamkas", force: true do |t|
    t.date     "datum"
    t.string   "poznamka"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id", null: false
  end

  create_table "ppls", force: true do |t|
    t.date     "datum"
    t.float    "castka"
    t.boolean  "zaplaceno"
    t.boolean  "dobirka"
    t.date     "datumOdeslani"
    t.text     "cisloBaliku"
    t.text     "variabilniSymbol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id"

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type"

  create_table "ratings", force: true do |t|
    t.integer  "customer_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",           limit: 100, null: false
    t.string   "password_digest", limit: 40,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uzivatels", force: true do |t|
    t.string   "password_digest", limit: 40,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",           limit: 100, null: false
  end

  create_table "zbozis", force: true do |t|
    t.string   "nazev"
    t.string   "popis"
    t.integer  "pocet_kusu"
    t.float    "cena_za_kus"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nakup_id"
  end

end
