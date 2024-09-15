# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_09_15_141539) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_cities_on_department_id"
    t.index ["name", "department_id"], name: "index_cities_on_name_and_department_id", unique: true
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_departments_on_name", unique: true
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "museum_registration_requests", force: :cascade do |t|
    t.string "museum_name", null: false
    t.string "museum_code", null: false
    t.string "museum_address", null: false
    t.string "manager_email", null: false
    t.integer "registration_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.bigint "department_id", null: false
    t.bigint "city_id", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "ci", default: "", null: false
    t.string "phone_number"
    t.text "feedback"
    t.index ["city_id"], name: "index_museum_registration_requests_on_city_id"
    t.index ["created_by_id"], name: "index_museum_registration_requests_on_created_by_id"
    t.index ["department_id"], name: "index_museum_registration_requests_on_department_id"
    t.index ["updated_by_id"], name: "index_museum_registration_requests_on_updated_by_id"
  end

  create_table "museums", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.text "about"
    t.string "email"
    t.string "phone"
    t.string "page"
    t.string "address"
    t.integer "status", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "museum_registration_request_id"
    t.bigint "department_id", null: false
    t.bigint "city_id", null: false
    t.float "latitude", default: 0.0
    t.float "longitude", default: 0.0
    t.boolean "free_entrance", default: true
    t.string "entrance_price"
    t.text "schedule"
    t.text "accessibility_features"
    t.index ["city_id"], name: "index_museums_on_city_id"
    t.index ["department_id"], name: "index_museums_on_department_id"
    t.index ["museum_registration_request_id"], name: "index_museums_on_museum_registration_request_id"
    t.index ["user_id"], name: "index_museums_on_user_id"
  end

  create_table "object_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "piece_collections", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", null: false
    t.bigint "museum_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_temporary", default: false
    t.text "description"
    t.index ["museum_id"], name: "index_piece_collections_on_museum_id"
  end

  create_table "pieces", force: :cascade do |t|
    t.string "name", null: false
    t.integer "number"
    t.text "description"
    t.string "measurement"
    t.text "in_display_info"
    t.integer "status", null: false
    t.bigint "piece_collection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "material_id"
    t.bigint "author_id"
    t.text "copyright_info"
    t.bigint "object_type_id"
    t.string "period"
    t.boolean "in_display", default: true
    t.text "conservation_state"
    t.index ["author_id"], name: "index_pieces_on_author_id"
    t.index ["material_id"], name: "index_pieces_on_material_id"
    t.index ["object_type_id"], name: "index_pieces_on_object_type_id"
    t.index ["piece_collection_id"], name: "index_pieces_on_piece_collection_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "ci"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cities", "departments"
  add_foreign_key "museum_registration_requests", "cities"
  add_foreign_key "museum_registration_requests", "departments"
  add_foreign_key "museum_registration_requests", "users", column: "created_by_id"
  add_foreign_key "museum_registration_requests", "users", column: "updated_by_id"
  add_foreign_key "museums", "cities"
  add_foreign_key "museums", "departments"
  add_foreign_key "museums", "museum_registration_requests"
  add_foreign_key "museums", "users"
  add_foreign_key "piece_collections", "museums"
  add_foreign_key "pieces", "authors"
  add_foreign_key "pieces", "materials"
  add_foreign_key "pieces", "object_types"
  add_foreign_key "pieces", "piece_collections"
end
