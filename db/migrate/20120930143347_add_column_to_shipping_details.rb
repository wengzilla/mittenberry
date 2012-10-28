class AddColumnToShippingDetails < ActiveRecord::Migration
  def change
    add_column :shipping_details, "order_id", :integer
  end
end
