class CreateCustomerSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_subscriptions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.integer :frequency

      t.timestamps
    end
  end
end
