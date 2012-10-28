class ShippingDetail < ActiveRecord::Base
  attr_accessible :name, :street1, :street2, :city, :state, :postal_code

  def to_s_wrapped
    ("<b>#{name}</b><br />#{street1} #{street2}<br />#{city}, #{state} #{postal_code}").html_safe
  end
end