class CustomerTea < ApplicationRecord
  belongs_to :customer_subscription
  belongs_to :tea
  has_one :customer, through: :customer_subscription
  has_one :subscription, through: :customer_subscription

  # validate :tea_limit

  # def tea_limit
  #   if customer_subscription.teas.count == subscription.tea_limit
  #     errors.add(:tea_limit, "Subscription has hit tea limit")
  #   end
  # end
end
