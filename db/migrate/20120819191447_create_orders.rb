class CreateOrders < ActiveRecord::Migration
  def change
    create_table "orders", :force => true do |t|
      t.string   "state"
      t.integer  "user_id"
      t.integer  "credit_card_id"
      t.integer  "shipping_detail_id"
      t.integer  "promo_code_id"
      t.datetime "created_at",         :null => false
      t.datetime "updated_at",         :null => false
    end

    create_table "order_products", :force => true do |t|
      t.integer  "product_id"
      t.integer  "order_id"
      t.integer  "price_in_cents"
      t.integer  "quantity"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
    end

    create_table "products", :force => true do |t|
      t.string   "name"
      t.integer  "price_in_cents"
      t.string   "photo"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
      t.string   "color"
      t.string   "sku"
    end
  end
end