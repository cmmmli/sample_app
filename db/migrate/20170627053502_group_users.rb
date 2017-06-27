class GroupUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :group_users, :role, :integer
  end
end
