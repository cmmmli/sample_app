class ReadingProgressPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    record.book_user.user_id == user.id
  end
end
