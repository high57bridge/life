class CreateDonations < ActiveRecord::Migration[6.1]
  def change
    create_table :donations do |t|
      t.integer :customer_id, null: false
      t.integer :payment, null: false
      t.integer :paymethod, null: false
      t.string :area, null: false
      t.timestamps
    end
  end
end
