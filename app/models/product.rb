class Product < ActiveRecord::Base
  attr_accessible :name, :description, :price, :photo, :sku, :color, :color_name

  has_many :order_products
  has_many :orders, :through => :order_products

  monetize :price_in_cents, :as => :price
end