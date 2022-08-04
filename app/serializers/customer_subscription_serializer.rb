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
          active: cust_subscription.active,
          price: cust_subscription.subscription.price,
          frequency: cust_subscription.frequency,
          teas: cust_subscription.teas.map {|tea| {name: tea.name} }
        }
      }
    }
  end

  def self.updated(cust_subscription)
    {
      data: {
        id: cust_subscription.id,
        name: cust_subscription.customer.full_name,
        subscription: {
          name: cust_subscription.subscription.name,
          active: cust_subscription.active
        }
      }
    }
  end

  def self.subscription_list(cust_subscriptions)
    {
      data: {
        customer: {
          id: cust_subscriptions.first.customer_id,
          name: cust_subscriptions.first.customer.full_name
        },
        subscriptions: cust_subscriptions.map do |sub|
                {
                  name: sub.subscription.name,
                  frequency: sub.frequency,
                  price: sub.subscription.price,
                  active: sub.active
                }
              end
      }
    }
  end
end
