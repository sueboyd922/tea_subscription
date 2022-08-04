require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :subscription }
    it { should have_many :customer_teas }
    it { should have_many(:teas).through(:customer_teas) }
  end

  describe 'validations' do
    it { should define_enum_for(:frequency) }
    it { should validate_presence_of :frequency }
    # it { should validate_presence_of :active }
  end

  describe 'instance methods' do
    let!(:teas) { create_list(:tea, 4) }
    let!(:customer) { create(:customer) }
    let!(:subscription) { Subscription.create!(name: "Tea Lover", price: 20, tea_limit: 3) }
    let!(:customer_sub) { customer.customer_subscriptions.create!(subscription: subscription, frequency: "monthly") }

    it '#add_teas' do
      chosen_teas = [teas[0].name, teas[2].name]

      customer_sub.add_teas(chosen_teas)

      expect(customer.teas).to eq([teas[0], teas[2]])
      expect(CustomerTea.all.count).to eq(2)
    end

    it '#change_active_status' do
      expect(customer_sub.active).to eq(true)
      customer_sub.change_active_status
      expect(customer_sub.active).to eq(false)

      expect(CustomerSubscription.find(customer_sub.id).active).to eq(false)

      customer_sub.change_active_status
      expect(customer_sub.active).to eq(true)
      expect(CustomerSubscription.find(customer_sub.id).active).to eq(true)
    end
  end
end
