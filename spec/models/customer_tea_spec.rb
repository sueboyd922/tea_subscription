require 'rails_helper'

RSpec.describe CustomerTea, type: :model do
  describe 'relationships' do
    it { should belong_to :customer_subscription }
    it { should belong_to :tea }
    it { should have_one(:customer).through(:customer_subscription) }
  end

  

end
