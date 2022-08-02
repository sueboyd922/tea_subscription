class AddActiveToCustomerSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :customer_subscriptions, :active, :boolean
  end
end
