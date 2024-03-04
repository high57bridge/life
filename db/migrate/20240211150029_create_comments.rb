class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :customer_id, null: false
      t.integer :post_id, null: false
      t.integer :parent_id, null: false
      t.text :comment, null: false
      t.index ["parent_id"], name: "index_comments_on_parent_id"
      t.index ["post_id"], name: "index_comments_on_post_id"
      t.index ["customer_id"], name: "index_comments_on_customer_id"
      t.timestamps 
    end
  end
end