class Tea < ApplicationRecord
  has_many :customer_teas
  has_many :customer_subscriptions, through: :customer_teas
  has_many :customers, through: :customer_subscriptions

  validates_presence_of :name, :description, :brew_time, :temperature
end
