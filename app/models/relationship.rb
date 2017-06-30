class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  
  # has_many :notifications, :as => notificationable
  has_many :notifications,
    foreign_key: :notificationable_id,
    foreign_type: :notificationable_type


end
