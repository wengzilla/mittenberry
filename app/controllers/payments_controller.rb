class PaymentsController < ApplicationController
  def create
    Stripe.api_key = "IaMZJiWB7nUekIFpvHsz36UOtO8Uo1TH"

    payment = Payment.new(:order => current_order, :payment_token => params[:stripe_token], :external_source => "Stripe")
    payment.charge

    unless payment.errors.any?
      render :json => "successful", :status => :created
    else
      render :json => payment.errors, :status => :bad_request
    end
  end
end
