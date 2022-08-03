class Api::V1::CustomerSubscriptionsController < ApplicationController
  before_action :validate_customer, only: [:update]

  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.customer_subscriptions
    require "pry"; binding.pry
    render json: CustomerSubscriptionSerializer.subscription_list(subscriptions.to_a), status: 200
  end

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
    # @cust_sub = CustomerSubscription.find(params[:id])
    @customer_sub.change_status(params[:active])
    render json: CustomerSubscriptionSerializer.updated(@customer_sub), status: 200
  end

  private
  def subscription_params
    params.permit(:subscription_id, :frequency, :customer_id)
  end

  def validate_customer
    @customer_sub = CustomerSubscription.find(params[:id])
    if @customer_sub.customer_id != params[:customer_id].to_i
      render json: {errors: "This subscription belongs to another customer" }, status: 400
    end
  end
end
