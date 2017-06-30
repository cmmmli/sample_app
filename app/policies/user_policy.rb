class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.activated?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    record.id == user.id
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end

  def following?
    true
  end

  def followers?
    true
  end

  def notifications?
    record.id == user.id
  end
end
