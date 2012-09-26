class Payment < ActiveRecord::Base
  attr_accessible :order, :payment_token

  belongs_to :order

  def charge
    charge = Stripe::Charge.create(
      :amount => order.total, # amount in cents, again
      :currency => "usd",
      :card => payment_token,
      :description => "Mittenberry Order"
    )
    save!
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.mesage}"
    errors.add :base, "There was a problem with your credit card."
  end
end