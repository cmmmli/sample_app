class CreateReadingProgresses < ActiveRecord::Migration[5.0]
  def change
    create_table :reading_progresses do |t|
      t.references :chapter, foreign_key: true
      t.references :book_user, foreign_key: true
      t.timestamps
    end
    add_index :reading_progresses, [:chapter_id, :book_user_id], unique: true
  end
end
