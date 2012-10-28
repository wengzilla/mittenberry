module ApplicationHelper
  def show_thank_you?
    params[:thanks].present?
  end
end
