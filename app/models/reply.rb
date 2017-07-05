class Reply < ApplicationRecord
  belongs_to :micropost
  belongs_to :destination, class_name: "Micropost"

  validates :micropost_id, presence: true
end
