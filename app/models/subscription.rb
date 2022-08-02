class Subscription < ApplicationRecord
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions
  has_many :customer_teas, through: :customer_subscriptions
  has_many :teas, through: :customer_teas
end
