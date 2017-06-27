class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :notificationable, polymorphic: true, index: false
      t.integer :notifier_id
      t.string :body
      t.boolean :opened, default: false
      t.timestamps
    end
  end
end
