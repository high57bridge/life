class CreatePublicNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :public_notifications do |t|

      t.timestamps
    end
  end
end
