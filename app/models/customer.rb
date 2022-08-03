class Customer < ApplicationRecord
  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions
  has_many :customer_teas, through: :customer_subscriptions
  has_many :teas, through: :customer_teas

  validates_presence_of :first_name, :last_name, :street, :zip_code, :state, :city, :email
  validates_uniqueness_of :email

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def active_subscriptions
    customer_subscriptions.where(active: true)
  end

  def inactive_subscriptions
    customer_subscriptions.where(active: false)
  end
end
