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

  private
  def subscription_params
    params.permit(:subscription_id, :frequency, :customer_id)
  end
end
