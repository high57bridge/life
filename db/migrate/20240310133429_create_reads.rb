class CreateReads < ActiveRecord::Migration[6.1]
  def change
    create_table :reads do |t|
      t.integer :customer_id, null: false
      t.integer :post_id, null: false
      t.boolean :complete, null: false
      t.timestamps
    end
  end
end
