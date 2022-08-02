require 'rails_helper'

RSpec.describe 'subscriptions requests', type: :feature do
  let!(:customer_1) { create(:customer) }
  let!(:customer_2) { create(:customer) }
  let!(:teas) { create_list(:tea, 10) }

  describe 'creating a subscription' do
    it 'can create a subscription for a customer' do
      subscription_params = {
        subscription_id: 1,
        frequency: "weekly"
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/customers/#{customer_1.id}/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)

      expect(response).to be_successful
    end
  end
end
