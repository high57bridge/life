class CreatePostHelpers < ActiveRecord::Migration[6.1]
  def change
    create_table :post_helpers do |t|
      t.timestamps
    end
  end
end
