class Payment < ActiveRecord::Base
  attr_accessible :order, :payment_token, :external_source, :response

  belongs_to :order
  validates_presence_of :order_id, :payment_token

  def charge
    Stripe.api_key = "IaMZJiWB7nUekIFpvHsz36UOtO8Uo1TH"

    charge = Stripe::Charge.create(
      :amount => order.total_in_cents, # amount in cents, again
      :currency => "usd",
      :card => payment_token,
      :description => "Mittenberry Order"
    )
    self.external_id = charge.id
    self.status = "paid"
    save!
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
  end

  def parsed_response
    @parsed_response ||= Hashie::Mash.new(JSON.parse(response))
  end

  def successful?
    status == "paid"
  end

  def formatted_last_four
    "XXXX-XXXX-XXXX-#{parsed_response.card.last_four}"
  end

  def card_type
    "#{parsed_response.card.type}"
  end
end