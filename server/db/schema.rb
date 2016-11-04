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

ActiveRecord::Schema.define(version: 20161104102936) do

  create_table "campaigns", force: :cascade do |t|
    t.datetime "start_date"
    t.integer  "winner_id"
  end

  create_table "campaigns_candidates", id: false, force: :cascade do |t|
    t.integer "candidate_id", null: false
    t.integer "campaign_id",  null: false
  end

  create_table "candidates", force: :cascade do |t|
    t.string  "name"
    t.string  "image_url"
    t.integer "number_campaigns_won"
    t.integer "number_campaigns_competed"
    t.integer "intelligence"
    t.integer "willpower"
    t.integer "charisma"
  end

end
