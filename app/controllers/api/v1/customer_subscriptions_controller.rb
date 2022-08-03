class Api::V1::CustomerSubscriptionsController < ApplicationController

  def create
    subscription = CustomerSubscription.new(subscription_params)
    if subscription.save
      subscription.add_teas(params[:tea])
      render json: CustomerSubscriptionSerializer.new_subscription(subscription), status: 201
    else
      render json: {errors: subscription.errors.full_messages.to_sentence }, status: 404
    end
  end

  def update
    cust_sub = CustomerSubscription.find(params[:id])
    cust_sub.change_status(params[:active])
    render json: CustomerSubscriptionSerializer.updated(cust_sub), status: 200
  end

  private
  def subscription_params
    params.permit(:subscription_id, :frequency, :customer_id)
  end
end
