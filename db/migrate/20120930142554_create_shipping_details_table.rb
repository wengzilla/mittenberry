class CreateShippingDetailsTable < ActiveRecord::Migration
  def change
    create_table "shipping_details", :force => true do |t|
      t.string   "name"
      t.string   "street1"
      t.string   "street2"
      t.string   "city"
      t.string   "state"
      t.string   "postal_code"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
