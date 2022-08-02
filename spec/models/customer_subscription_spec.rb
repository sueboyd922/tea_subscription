require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :subscription }
    it { should have_many :customer_teas }
    it { should have_many(:teas).through(:customer_teas) }
  end
end
