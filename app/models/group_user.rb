class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :group_id, presence: true, uniqueness: {:scope => :user_id}
  validates :user_id, presence: true
end
