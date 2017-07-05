class RenameDestinationColumnToReplies < ActiveRecord::Migration[5.0]
  def change
    rename_column :replies, :destination, :destination_id
  end
end
