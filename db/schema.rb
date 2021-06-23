
ActiveRecord::Schema.define(version: 2021_06_22_061619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "detail", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
