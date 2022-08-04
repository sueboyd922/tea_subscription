require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :customer_subscriptions }
    it { should have_many(:subscriptions).through(:customer_subscriptions) }
    it { should have_many(:customer_teas).through(:customer_subscriptions) }
    it { should have_many(:teas).through(:customer_teas) }
  end

  describe 'validations' do
    it { should validate_presence_of (:first_name) }
    it { should validate_presence_of (:last_name) }
    it { should validate_presence_of (:street) }
    it { should validate_presence_of (:city) }
    it { should validate_presence_of (:zip_code) }
    it { should validate_presence_of (:state) }
    it { should validate_presence_of (:email) }
    it { should validate_uniqueness_of (:email) }
  end

  describe 'instance methods' do
    let!(:customer) { create(:customer, first_name: "Susan", last_name: "Boyd") }
    let!(:customer_2) { create(:customer) }
    let!(:subscription) { Subscription.create!(name: "Single Tea", price: 10, tea_limit: 1)}

    it '#full_name' do
      expect(customer.full_name).to eq("Susan Boyd")
    end

    it '#active_subscriptions' do
      sub_1 = customer.customer_subscriptions.create!(subscription: subscription, frequency: "weekly")
      sub_2 = customer.customer_subscriptions.create!(subscription: subscription, frequency: "weekly", active: false)
      sub_3 = customer.customer_subscriptions.create!(subscription: subscription, frequency: "weekly")
      sub_4 = customer_2.customer_subscriptions.create!(subscription: subscription, frequency: "weekly")

      expect(customer.active_subscriptions).to eq([sub_1, sub_3])
    end

    it '#inactive_subscriptions' do
      sub_1 = customer.customer_subscriptions.create!(subscription: subscription, frequency: "weekly")
      sub_2 = customer.customer_subscriptions.create!(subscription: subscription, frequency: "weekly", active: false)
      sub_3 = customer.customer_subscriptions.create!(subscription: subscription, frequency: "weekly")
      sub_4 = customer_2.customer_subscriptions.create!(subscription: subscription, frequency: "weekly", active: false)

      expect(customer.inactive_subscriptions).to eq([sub_2])
    end
  end
end
