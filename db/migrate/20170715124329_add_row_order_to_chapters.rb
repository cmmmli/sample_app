class AddRowOrderToChapters < ActiveRecord::Migration[5.0]
  def change
    add_column :chapters, :row_order, :integer
    remove_index :chapters, name: "index_chapters_on_book_id_and_chapter_num"
    remove_column :chapters, :chapter_num
  end
end
