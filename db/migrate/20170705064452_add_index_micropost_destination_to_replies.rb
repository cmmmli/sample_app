class AddIndexMicropostDestinationToReplies < ActiveRecord::Migration[5.0]
  def change
    add_index :replies, :destination_id
    add_index :replies, [:micropost_id, :destination_id], unique: true
  end
end
