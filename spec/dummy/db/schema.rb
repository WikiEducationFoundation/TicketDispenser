# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_10_173213) do

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_dispenser_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "kind", limit: 1, default: 0
    t.integer "sender_id"
    t.bigint "ticket_id"
    t.boolean "read", default: false, null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "details"
    t.index ["ticket_id"], name: "index_ticket_dispenser_messages_on_ticket_id"
  end

  create_table "ticket_dispenser_tickets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "project_id"
    t.integer "owner_id"
    t.integer "status", limit: 1, default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_ticket_dispenser_tickets_on_owner_id"
    t.index ["project_id"], name: "index_ticket_dispenser_tickets_on_project_id"
  end

  create_table "ticketing_engine_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "kind", limit: 1, default: 0
    t.integer "sender_id"
    t.bigint "ticket_id"
    t.boolean "read", default: false, null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticketing_engine_messages_on_ticket_id"
  end

  create_table "ticketing_engine_tickets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "course_id"
    t.integer "owner_id"
    t.integer "status", limit: 1, default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_ticketing_engine_tickets_on_course_id"
    t.index ["owner_id"], name: "index_ticketing_engine_tickets_on_owner_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "username"
    t.string "real_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
