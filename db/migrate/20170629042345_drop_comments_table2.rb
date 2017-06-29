class DropCommentsTable2 < ActiveRecord::Migration[5.0]
  def change
    drop_table :comments
  end
end
