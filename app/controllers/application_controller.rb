class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_order
    @current_order ||= (get_order_from_cookie || create_new_order)
  end
  helper_method :current_order

  def create_new_order
    Order.new
  end

  def get_order_from_cookie
    Order.find_by_id(cookies["mb_order_id"]) if cookies["mb_order_id"]
  end

  def set_current_order(order)
    @current_order = order
    cookies["mb_order_id"]  = { :value => @current_order.id,
                               :expires => Order::COOKIE_DURATION.from_now }
  end

  def clear_order_from_cookie
    current_order
    cookies["mb_order_id"] = nil
    current_order
  end
end
