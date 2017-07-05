class CreateTableReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.references :micropost
      t.integer :destination
      t.timestamps
    end
  end
end
