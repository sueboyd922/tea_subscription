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
    it '#full_name' do
      customer = create(:customer, first_name: "Susan", last_name: "Boyd")

      expect(customer.full_name).to eq("Susan Boyd")
    end
  end
end
