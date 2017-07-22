class BookUser < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :reading_progresses, dependent: :destroy

  validates :book_id, presence: true, uniqueness: {:scope => :user_id}
  validates :user_id, presence: true


  def read_status
    chapters_size = self.book.chapters.count.to_f
    read_chapters_size = self.reading_progresses.count.to_f
    logger.info("––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––")
    logger.info(read_chapters_size)
    read_chapters_size / chapters_size * 100.0
  end
end
