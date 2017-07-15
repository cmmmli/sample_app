class Chapter < ApplicationRecord
  belongs_to :book, optional: true

  validates :title, presence: true, length: {maximum: 100}

  default_scope -> {order(:chapter_num)}


  def add_chapter_num(num)
      self.chapter_num = num
  end
end
