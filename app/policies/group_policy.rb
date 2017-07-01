class GroupPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user.admin? || record.group_users.find_by(user_id: user.id).role == 1
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || record.group_users.find_by(user_id: user.id).role == 1
  end

  def members?
    record.users.include?(user)
  end
end
