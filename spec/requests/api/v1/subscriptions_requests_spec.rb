require 'rails_helper'

RSpec.describe 'subscriptions requests', type: :feature do
  let!(:customer_1) { create(:customer) }
  let!(:customer_2) { create(:customer) }
  let!(:teas) { create_list(:tea, 10) }

  describe 'creating a subscription' do
    it 'can create a subscription for a customer' do
      require "pry"; binding.pry
    end
  end
end
