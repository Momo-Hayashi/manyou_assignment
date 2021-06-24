ActiveRecord::Schema.define(version: 2021_06_24_115220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "detail", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expire_on", default: -> { "now()" }, null: false
    t.integer "status", default: 0, null: false
    t.index ["name"], name: "index_tasks_on_name"
  end

end
