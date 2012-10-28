class Order < ActiveRecord::Base
  attr_accessible :user, :shipping_detail_attributes, :payment_attributes, :state
  
  has_many :order_products, :dependent => :destroy
  has_many :products, :through => :order_products
  has_one :payment
  has_one :shipping_detail, :dependent => :destroy

  accepts_nested_attributes_for :shipping_detail
  accepts_nested_attributes_for :payment

  COOKIE_DURATION = 1.week

  def add(product, quantity=1)
    if op = order_products.find_by_product_id(product.id)
      op.update_attributes(quantity: op.quantity + quantity.to_i)
    else
      order_products.create(product: product, quantity: quantity, price: product.price)
    end
  end

  def total_in_cents
    order_products.inject(0){ |sum, o_p| sum += o_p.quantity * o_p.price_in_cents }
  end

  def total
    BigDecimal.new(total_in_cents) / 100
  end

  def is_valid?
    shipping_detail.present? && payments.any?(&:successful?)
  end

  def add_shipping_detail(params)
    shipping_detail ? shipping_detail.update_attributes(params) : create_shipping_detail(params)
    shipping_detail
  end

  def add_payment(params)
    payment ? payment.update_attributes(params) : create_payment(params)
    payment
  end

  def total_quantity
    order_products.inject(0){|total, o_p| total += o_p.quantity}
  end

  def created?
    state == "created"
  end
end

