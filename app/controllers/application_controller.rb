class ApplicationController < ActionController::API

  def existing_customer
    @customer = Customer.find(params[:customer_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: {errors: e.message}, status: 404
  end
end
