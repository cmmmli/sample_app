class MicropostPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    record.user_id == user.id
  end
end
