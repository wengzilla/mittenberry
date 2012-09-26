class OrderProductsController < ApplicationController
  before_filter :load_product

  def create
    if current_order.new_record?
      current_order.save!
      set_current_order(current_order) 
    end
    # order_product_params = JSON.parse(params[:order_product] || {})
    order_product_params = params[:order_product]
    quantity = order_product_params[:quantity]

    if current_order.add(@product, quantity)
      respond_to do |format|
        format.json do
          render :json => {flash: "#{@product.name} was added to your order", order_products: current_order.order_products}
        end
        format.html do
          redirect_to root_path, :notice => "#{@product.name} was added to your order"
        end
      end
    else
      respond_to do |format|
        format.json do
          render :json => @order_product.errors.to_json
        end
        format.html do
          flash.now[:error] = @order_product.full_error_messages
          render "pages#index"
        end
      end
    end
  end

  def load_product
    @product = Product.find(params[:order_product].delete(:product_id))

    unless @product
      redirect_to root_path, :notice => "That product could not be found."
    end
  end
end
