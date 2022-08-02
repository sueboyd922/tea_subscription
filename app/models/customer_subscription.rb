class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription
  has_many :customer_teas
  has_many :teas, through: :customer_teas
end
