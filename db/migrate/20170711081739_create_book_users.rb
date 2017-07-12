class CreateBookUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :book_users do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.integer    :role, default: 2
      t.timestamps
    end
    add_index :book_users, [:book_id, :user_id], unique: true
  end
end
