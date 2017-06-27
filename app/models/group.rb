class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users

  validates :name, presence: true, length: {maximum: 50}
  validates :detail, presence: true
end
