class OrdersChangeColumnStateToHaveDefault < ActiveRecord::Migration
  def change
    change_column :orders, :state, :string, :default => "created"
  end
end
