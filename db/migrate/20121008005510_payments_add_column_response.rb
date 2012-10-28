class PaymentsAddColumnResponse < ActiveRecord::Migration
  def change
    add_column :payments, :response, :text
    add_column :products, :color_name, :string
  end
end
