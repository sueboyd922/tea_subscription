require 'rails_helper'

RSpec.describe 'subscriptions requests', type: :request do
  let!(:customer_1) { create(:customer) }
  let!(:customer_2) { create(:customer) }
  let!(:teas) { create_list(:tea, 10) }
  let!(:subscription_1) { Subscription.create!(name: "Single Tea", price: 10, tea_limit: 1) }
  let!(:subscription_2) { Subscription.create!(name: "Tea Lover", price: 20, tea_limit: 3) }
  let!(:subscription_3) { Subscription.create!(name: "Tea Fiend", price: 30, tea_limit: 5) }

  describe 'creating a subscription' do
    it 'can create a subscription for a customer' do
      tea = teas.sample
      subscription_params = {
        subscription_id: subscription_1.id,
        frequency: "weekly",
        tea: [tea.name]
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{customer_1.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to be(201)
      expect(subscription_response[:data]).to be_a Hash
      expect(subscription_response[:data]).to have_key(:name)
      expect(subscription_response[:data]).to have_key(:address)
      expect(subscription_response[:data]).to have_key(:subscription)
      expect(subscription_response[:data][:subscription][:teas]).to be_an Array
    end

    it 'throws an error if the customer does not exist' do
      tea = teas.sample
      subscription_params = {
        subscription_id: subscription_1.id,
        frequency: "weekly",
        tea: [tea.name]
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{customer_2.id + 1}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(subscription_response[:errors]).to eq("Couldn't find Customer with 'id'=#{customer_2.id + 1}")
    end

    it 'throws an error if an attribute is missing' do
      tea = teas.sample
      subscription_params = {
        subscription_id: subscription_1.id,
        tea: [tea.name]
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{customer_2.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(subscription_response[:errors]).to eq("Frequency can't be blank")
    end

    it 'can not add more teas to the customer subsciption than the subscription allows' do
      tea = teas[0]
      tea_2 = teas[4]
      subscription_params = {
        subscription_id: subscription_1.id,
        frequency: "weekly",
        tea: [tea.name, tea_2.name]
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{customer_2.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_response[:errors]).to eq("Tea limit This subscription has a limit of 1 teas.")
    end
  end

  describe 'updating a customer subscription' do
    it 'can make a subsciption inactive' do
      customer_subscription = customer_1.customer_subscriptions.create(subscription_id: subscription_2.id, frequency: "yearly")

      expect(customer_subscription.active).to be true

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customers/#{customer_1.id}/subscriptions/#{customer_subscription.id}", headers: headers, params: JSON.generate({update: "active status"})

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_response[:data][:subscription][:active]).to be false
      expect(CustomerSubscription.find(customer_subscription.id).active).to be false
    end

    it 'throws an error if the customer does not exist' do
      customer_subscription = customer_1.customer_subscriptions.create(subscription_id: subscription_2.id, frequency: "yearly")

      expect(customer_subscription.active).to be true

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customers/#{customer_2.id + 1}/subscriptions/#{customer_subscription.id}", headers: headers, params: JSON.generate({update: "active status"})

      subscription_response = JSON.parse(response.body, symbolize_names: true)
      expect(subscription_response[:errors]).to eq("Couldn't find Customer with 'id'=#{customer_2.id + 1}")
    end

    it 'throws an error if the customer subscription does not exist' do
      customer_subscription = customer_1.customer_subscriptions.create(subscription_id: subscription_2.id, frequency: "yearly")

      expect(customer_subscription.active).to be true

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customers/#{customer_2.id}/subscriptions/#{customer_subscription.id + 1}", headers: headers, params: JSON.generate({update: "active status"})

      subscription_response = JSON.parse(response.body, symbolize_names: true)
      expect(subscription_response[:errors]).to eq("Couldn't find CustomerSubscription with 'id'=#{customer_subscription.id + 1}")
    end


    it 'throws an error if the customer id does not match the subscriptions customer id' do
      customer_subscription = customer_1.customer_subscriptions.create(subscription_id: subscription_2.id, frequency: "yearly")

      expect(customer_subscription.active).to be true

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customers/#{customer_2.id}/subscriptions/#{customer_subscription.id}", headers: headers, params: JSON.generate({update: "active status"})

      subscription_response = JSON.parse(response.body, symbolize_names: true)
      expect(subscription_response[:errors]).to eq("This subscription belongs to another customer")
    end
  end

  describe 'getting all of a customers subscriptions' do
    let!(:cust_sub_1) {customer_1.customer_subscriptions.create!(subscription: subscription_1, active: true, frequency: "weekly")}
    let!(:cust_sub_2) {customer_1.customer_subscriptions.create!(subscription: subscription_2, active: false, frequency: "weekly")}
    let!(:cust_sub_3) {customer_1.customer_subscriptions.create!(subscription: subscription_2, active: true, frequency: "weekly")}
    let!(:cust_sub_4) {customer_1.customer_subscriptions.create!(subscription: subscription_3, active: true, frequency: "weekly")}

    it 'can get all of a customers subscriptions' do
      get "/api/v1/customers/#{customer_1.id}/subscriptions"
      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_response[:data][:subscriptions].count).to eq(4)
    end

    it 'can return all active subscriptions' do
      get "/api/v1/customers/#{customer_1.id}/subscriptions?status=active"
      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_response[:data][:subscriptions].count).to eq(3)
    end

    it 'can return all inactive subscriptions' do
      get "/api/v1/customers/#{customer_1.id}/subscriptions?status=inactive"
      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_response[:data][:subscriptions].count).to eq(1)
    end

    it 'throws an error if customer does not exist' do
      get "/api/v1/customers/#{customer_2.id + 1}/subscriptions?status=inactive"
      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_response[:errors]).to eq("Couldn't find Customer with 'id'=#{customer_2.id + 1}")
    end
  end
end
