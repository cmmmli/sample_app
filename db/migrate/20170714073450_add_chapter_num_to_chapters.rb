class AddChapterNumToChapters < ActiveRecord::Migration[5.0]
  def change
    add_column :chapters, :chapter_num, :integer
    add_index :chapters, [:book_id, :chapter_num], unique: true
  end
end
