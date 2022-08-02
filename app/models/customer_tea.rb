class CustomerTea < ApplicationRecord
  belongs_to :customer_subscription
  belongs_to :tea
  has_one :customer, through: :customer_subscription
end
