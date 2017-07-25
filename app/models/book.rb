class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy
  accepts_nested_attributes_for :chapters, allow_destroy: true
  has_many :book_users, dependent: :destroy
  has_many :users, through: :book_users
  has_many :reading_progresses, through: :book_users
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags
  accepts_nested_attributes_for :book_tags, allow_destroy: true

  validates :title, presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :content, presence: true
end
