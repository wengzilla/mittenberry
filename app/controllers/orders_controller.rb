class OrdersController < ApplicationController

  def edit
    @order = Order.find_by_id(params[:id])
    @payment = @order.payment
    
    unless @order.created?
      clear_order_from_cookie
      redirect_to root_path, :notice => "This order has already been paid for."
    end
  end

  def place
    @order = Order.find_by_id(params[:id])
    @payment = @order.payment

    @payment.charge unless @payment.successful?

    if @payment.errors && !@payment.successful?
      render "edit"
    else
      @order.update_attributes(:state => "paid")
      @order = clear_order_from_cookie
      redirect_to root_path(:thanks => "you") + "#thanks"
    end
  end

  def add_details
    add_additional_payment_attributes
    if current_order.add_shipping_detail(params[:shipping_detail]) && current_order.add_payment(params[:payment])
      redirect_to edit_order_path(current_order)
    else
      redirect_to root_path, :notice => "Checking out has failed. Please contact customer service at custserv@mittenberry.com."
    end
  end

  private

  def add_additional_payment_attributes
    params[:payment].merge!({:external_source => "Stripe", :order => current_order}) if params[:payment]
  end
end