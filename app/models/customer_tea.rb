class CustomerTea < ApplicationRecord
  belongs_to :customer_subscription
  belongs_to :tea
end
