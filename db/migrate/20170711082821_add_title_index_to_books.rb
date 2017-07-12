class AddTitleIndexToBooks < ActiveRecord::Migration[5.0]
  def change
    add_index :books, :title, unique: :true
  end
end
