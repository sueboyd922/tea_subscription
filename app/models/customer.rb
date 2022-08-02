class Customer < ApplicationRecord
  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions
  has_many :customer_teas, through: :customer_subscriptions
  has_many :teas, through: :customer_teas

  validates_presence_of :first_name, :last_name, :street, :zip_code, :state, :city, :email
  validates_uniqueness_of :email
end
