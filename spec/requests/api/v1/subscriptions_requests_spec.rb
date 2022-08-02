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
      subscription_params = {
        subscription_id: subscription_1.id,
        frequency: "weekly"
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{customer_1.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
    end
  end
end
