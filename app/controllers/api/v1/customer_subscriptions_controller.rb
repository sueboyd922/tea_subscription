class Api::V1::CustomerSubscriptionsController < ApplicationController
  before_action :existing_customer, only: [:index, :create, :update]
  before_action :existing_customer_subscription, only: [:update]
  before_action :validate_customer, only: [:update]

  def index
    render json: CustomerSubscriptionSerializer.subscription_list(choose_subscriptions.to_a), status: 200
  end

  def create
    subscription = CustomerSubscription.new(subscription_params)
    if subscription.save
      subscription.add_teas(params[:tea])
      render json: CustomerSubscriptionSerializer.new_subscription(subscription), status: 201
    else
      render_error(subscription.errors.full_messages.to_sentence, 400)
    end
  end

  def update
    if params[:update] == "active status"
      @customer_subscription.change_active_status
    end
    render json: CustomerSubscriptionSerializer.updated(@customer_subscription), status: 200
  end

  private
  def subscription_params
    params.permit(:subscription_id, :frequency, :customer_id)
  end

  def validate_customer
    if @customer_subscription.customer_id != @customer.id
      render_error("This subscription belongs to another customer", 400)
    end
  end

  def choose_subscriptions
    if params[:status] == "active"
      @customer.active_subscriptions
    elsif params[:status] == "inactive"
      @customer.inactive_subscriptions
    else
      @customer.customer_subscriptions
    end
  end
end
