class MicropostPolicy < ApplicationPolicy
  def create?
    user.activated?
  end

  def destroy?
    record.user_id == user.id
  end
end
