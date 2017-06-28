class AddIndexToGroupUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :group_users, :group_id
    add_index :group_users, :user_id
    add_index :group_users, [:group_id, :user_id], unique: true
  end
end
