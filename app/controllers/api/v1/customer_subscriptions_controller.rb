class Api::V1::CustomerSubscriptionsController < ApplicationController

  def create
    subscription = CustomerSubscription.new(subscription_params)
    subscription.save
  end

  private
  def subscription_params
    params.permit(:subscription_id, :frequency, :customer_id)
  end
end
