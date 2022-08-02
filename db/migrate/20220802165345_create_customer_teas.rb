class CreateCustomerTeas < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_teas do |t|
      t.references :customer_subscription, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
