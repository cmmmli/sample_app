class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.references :user
      t.references :micropost
      t.timestamps
    end

    add_column :microposts, :reply, :boolean, default: false
  end
end
