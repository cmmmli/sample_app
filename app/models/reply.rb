class Reply < ApplicationRecord
  belongs_to :micropost
  belongs_to :destination, class_name: "Micropost"
  has_many :notifications,
    foreign_key: :notificationable_id,
    foreign_type: :notificationable_type

  validates :micropost_id, presence: true
end
