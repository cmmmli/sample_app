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
    if bookuser = record.book_users.find_by(user_id: user.id)
      bookuser.role == 1
    end
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || record.book_users.find_by(user_id: user.id).role == 1
  end

  def tag_manager?
    true
  end

end
