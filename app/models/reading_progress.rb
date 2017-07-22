class ReadingProgress < ApplicationRecord
  belongs_to :chapter
  belongs_to :book_user
end
