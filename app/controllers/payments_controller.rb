class PaymentsController < ApplicationController
  def create
    Stripe.api_key = "IaMZJiWB7nUekIFpvHsz36UOtO8Uo1TH"

    order = Order.find_by_id(params[:order_id])
    payment = Payment.new(:order => order, :payment_token => params[:stripe_token])
    payment.charge

    unless payment.errors.any?
      render :json => "successful"
    else
      render :json => payment.errors
    end
  end
end
