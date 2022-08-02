class Customer < ApplicationRecord
  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions
  has_many :teas, through: :customer_subscriptions
end
