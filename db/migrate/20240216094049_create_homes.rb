class CreateHomes < ActiveRecord::Migration[6.1]
  def change
    create_table :homes do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :opinion, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
