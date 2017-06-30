class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :detail, presence: true
end
