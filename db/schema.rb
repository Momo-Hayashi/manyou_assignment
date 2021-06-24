ActiveRecord::Schema.define(version: 2021_06_24_030814) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "detail", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expire_on", default: -> { "now()" }, null: false
  end

end
