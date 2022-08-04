class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription
  has_many :customer_teas, dependent: :destroy
  has_many :teas, through: :customer_teas

  validates_presence_of :frequency
  enum frequency: ["weekly", "monthly", "every 3 months", "yearly"]

  def add_teas(teas)
    teas.each do |tea|
      tea = Tea.find_by(name: tea)
      CustomerTea.create!(tea_id: tea.id, customer_subscription_id: self.id)
    end
  end

  def change_active_status
    toggle!(:active)
  end
end
