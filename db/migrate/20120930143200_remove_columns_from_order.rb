class RemoveColumnsFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :credit_card_id
    remove_column :orders, :user_id
    remove_column :orders, :shipping_detail_id
  end
end
