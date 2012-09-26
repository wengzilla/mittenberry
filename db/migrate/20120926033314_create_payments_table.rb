class CreatePaymentsTable < ActiveRecord::Migration
  def change
    create_table "payments", :force => true do |t|
      t.integer  "order_id",           :null => false
      t.string   "payment_token",      :null => false
      t.datetime "created_at",         :null => false
      t.datetime "updated_at",         :null => false
    end
  end
end
