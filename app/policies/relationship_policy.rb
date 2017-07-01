class RelationshipPolicy < ApplicationPolicy
  def create?
    user.activated?
  end

  def destroy?
    record.follower_id == user.id
  end
end
