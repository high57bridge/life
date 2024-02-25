class CreateDonationDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :donation_details do |t|
      t.integer "donation_id", null: false
      t.string "payment_amount", null: false
      t.string "payment_method", null: false
      t.string "area", null: false
      t.timestamps
    end
  end
end
