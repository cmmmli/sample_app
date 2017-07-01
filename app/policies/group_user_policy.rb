class GroupUserPolicy < ApplicationPolicy
  def create?
    user.activated?
  end

  def destroy?
    record.group.users.include?(user)
  end
end
