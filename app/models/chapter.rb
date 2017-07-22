class Chapter < ApplicationRecord
  include RankedModel
  ranks :row_order

  belongs_to :book, optional: true
  has_many :reading_progresses, dependent: :destroy

  validates :title, presence: true, length: {maximum: 100}

  default_scope -> {order(:row_order)}

  def add_chapter_num(num)
      self.chapter_num = num
  end

  def read?(bookuser)
    progress = self.reading_progresses.find_by(book_user_id: bookuser.id)
  end

  def read(bookuser)
    self.reading_progresses.create(book_user_id: bookuser.id)
  end

  def unread(bookuser)
    self.reading_progresses.find_by(book_user_id: bookuser.id).destroy
  end
end
