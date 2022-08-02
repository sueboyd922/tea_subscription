class CreateTeas < ActiveRecord::Migration[6.0]
  def change
    create_table :teas do |t|
      t.string :name
      t.string :description
      t.integer :temperature
      t.integer :brew_time

      t.timestamps
    end
  end
end
