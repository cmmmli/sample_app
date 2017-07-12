class Chapter < ApplicationRecord
  belongs_to :book, optional: true

  validates :title, presence: true, length: {maximum: 100}
end
