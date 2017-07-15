class BookUserPolicy < ApplicationPolicy
  def create?
    user.activated?
  end

  def destroy?
    record.book.users.include?(user)
  end
end
