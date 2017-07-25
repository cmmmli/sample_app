class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  default_scope -> {order(created_at: :desc)}

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :body, presence: true, length: {maximum: 100}
end
