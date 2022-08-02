class Tea < ApplicationRecord
  has_many :customer_teas
  has_many :customer_subscriptions, through: :customer_teas
  has_many :customers, through: :customer_subscriptions
end
