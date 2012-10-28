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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121008022221) do

  create_table "order_products", :force => true do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "price_in_cents"
    t.integer  "quantity"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "state",         :default => "created"
    t.integer  "promo_code_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "order_id",                               :null => false
    t.string   "payment_token",                          :null => false
    t.string   "status",          :default => "created"
    t.string   "external_source",                        :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "external_id"
    t.text     "response"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "price_in_cents"
    t.string   "photo"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "color"
    t.string   "sku"
    t.string   "color_name"
  end

  create_table "shipping_details", :force => true do |t|
    t.string   "name"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

end
