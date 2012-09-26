class PagesController < ApplicationController
  def index
    @order_product = OrderProduct.new
    @products = Product.all
  end
end
