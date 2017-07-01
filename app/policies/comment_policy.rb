class CommentPolicy < ApplicationPolicy

  def create?
    true
  end

  def destroy?
    record.user_id == user.id || user.admin? || record.group.group_users.where(role: 1).include?(user)
  end
end
