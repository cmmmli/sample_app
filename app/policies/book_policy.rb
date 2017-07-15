class BookPolicy < ApplicationPolicy
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
    user.admin? || record.book_users.find_by(user_id: user.id).role == 1
  end

  def edit?
    update?
  end

  def destroy?
    record.book_users.find_by(user_id: user.id).role == 1
  end

end
