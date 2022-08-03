class CustomerSubscriptionSerializer

  def self.new_subscription(cust_subscription)
    {
      data: {
        id: cust_subscription.id,
        name: cust_subscription.customer.full_name,
        address: {
          street: cust_subscription.customer.street,
          city: cust_subscription.customer.city,
          state: cust_subscription.customer.state,
          zip_code: cust_subscription.customer.zip_code
        },
        subscription: {
          name: cust_subscription.subscription.name,
          price: cust_subscription.subscription.price,
          frequency: cust_subscription.frequency,
          teas: cust_subscription.teas.map {|tea| {name: tea.name} }
        }
      }
    }
  end
end
