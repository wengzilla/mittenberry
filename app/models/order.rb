class Order < ActiveRecord::Base
  attr_accessible :user
  
  has_many :order_products, :dependent => :destroy
  has_many :products, :through => :order_products

  COOKIE_DURATION = 1.week

  def add(product, quantity=1)
    if op = order_products.find_by_product_id(product.id)
      op.update_attributes(quantity: op.quantity + quantity.to_i)
    else
      order_products.create(product: product, quantity: quantity, price: product.price)
    end
  end

  def total
    order_products.inject(0){ |sum, o_p| sum += o_p.quantity * o_p.price_in_cents }
  end
end

