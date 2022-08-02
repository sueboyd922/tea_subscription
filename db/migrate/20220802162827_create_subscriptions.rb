class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.integer :price
      t.integer :tea_limit

      t.timestamps
    end
  end
end
