class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy
  accepts_nested_attributes_for :chapters, allow_destroy: true
  has_many :book_users, dependent: :destroy
  has_many :users, through: :book_users
  has_many :reading_progresses, through: :book_users

  validates :title, presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :content, presence: true

end
