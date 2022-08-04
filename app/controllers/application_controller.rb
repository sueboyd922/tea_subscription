class ApplicationController < ActionController::API

  def existing_customer
    @customer = Customer.find(params[:customer_id])
  rescue ActiveRecord::RecordNotFound => e
    render_error(e.message, 404)
  end

  def existing_customer_subscription
    @customer_subscription = CustomerSubscription.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render_error(e.message, 404)
  end

  def render_error(message, status)
    render json: {errors: message}, status: status
  end
end
