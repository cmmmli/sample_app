class BookUsersController < ApplicationController
  before_action :logged_in_user
  before_action :set_book_user, only: :destroy
  before_action :authorize_book_user, only: :create

  def create
    @book = Book.find(params[:book_id])
    current_user.register_book_as_normal_user(@book)
    respond_to do |format|
      format.html {redirect_to @book}
    end
  end

  def destroy
    @book = @book_user.book
    current_user.delete_book_registration(@book)
    respond_to do |format|
      format.html {redirect_to @book}
    end
  end

  private
    def set_book_user
      @book_user = BookUser.find(params[:id])
      authorize @book_user
    end

    def authorize_book_user
      authorize BookUser
    end
end
