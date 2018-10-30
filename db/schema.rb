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

ActiveRecord::Schema.define(version: 2019_04_17_011304) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "btcpayserverlogs", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals", force: :cascade do |t|
    t.integer "admin_id"
    t.integer "satoshi_amount"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "currency"
    t.index ["admin_id"], name: "index_goals_on_admin_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "invoice_id"
    t.string "invoice_url"
    t.string "invoice_status"
    t.datetime "invoiceTime"
    t.datetime "expirationTime"
    t.integer "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.integer "tier_id"
    t.string "order_id"
    t.string "duration"
    t.boolean "redeemed"
    t.integer "satoshi_amount"
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tier_id"
    t.text "content"
    t.string "title"
    t.boolean "public_post"
  end

  create_table "settings", force: :cascade do |t|
    t.integer "admin_id"
    t.string "name"
    t.string "tagline"
    t.text "main_info"
    t.string "btcpayserver_keypair"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "btcpayserver_url"
    t.string "btcpayserver_token"
    t.string "btcpayserver_pem"
    t.string "currency"
    t.text "thankyou_email"
    t.text "reminder_email"
    t.text "goodbye_email"
    t.text "recurring_payment_link_email"
    t.text "invoice_email"
    t.string "origin_email"
    t.string "mail_user_name"
    t.string "mail_password"
    t.string "mail_domain"
    t.string "mail_address"
    t.integer "mail_port"
    t.string "mail_authentication"
    t.boolean "mail_enable_starttls_auto"
    t.string "mail_host"
    t.text "user_credentials_email"
    t.text "ga_script"
    t.string "domain"
    t.string "embedded_media"
    t.boolean "youtube_link"
    t.index ["admin_id"], name: "index_settings_on_admin_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "last_payment_date"
    t.datetime "last_email_reminder"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.string "invoice_id"
    t.string "invoice_status"
    t.integer "tier_id"
    t.string "invoice_url"
    t.string "uuid"
    t.boolean "anonymous"
    t.datetime "expires_on"
  end

  create_table "tiers", force: :cascade do |t|
    t.integer "admin_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.index ["admin_id"], name: "index_tiers_on_admin_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "subscription_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["subscription_id"], name: "index_users_on_subscription_id"
  end

end
