class OrderProduct < ActiveRecord::Base
  attr_accessible :quantity, :product, :price, :product_id

  belongs_to :order
  belongs_to :product

  monetize :price_in_cents, :as => :price

  extend Forwardable
  def_delegators :product, :name

  def subtotal
    price * quantity
  end
end