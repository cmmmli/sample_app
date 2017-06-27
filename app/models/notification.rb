class Notification < ApplicationRecord
  belongs_to :notificationable, polymorphic: true
  default_scope -> {order(created_at: :desc)}
end
