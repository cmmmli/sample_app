class BooksController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :set_book, only: [:show, :destroy, :edit, :update, :tag_manager]
  before_action :authorize_book, only: [:index, :new, :create]

  def index
    @books = Book.all.includes(:tags).paginate(page: params[:page])
  end

  def show
    @users = @book.users
    @book_user = @book.book_users.find_by(user_id: current_user.id)
    @chapters = @book.chapters
    @tags = @book.tags
  end

  def new
    @book = Book.new
    @book.chapters.build
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      current_user.register_book_as_owner(@book)
      redirect_to book_url(@book)
    else
      render 'new'
    end
  end

  def edit
    @chapters = @book.chapters.rank(:row_order)
  end

  def update
    if @book.update_attributes(book_params)
      flash[:success] = "book updated"
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = "Book deleted"
    redirect_to books_url
  end

  def tag_manager
    @book_tags = @book.book_tags
  end

  private
    def book_params
      params.require(:book).permit(:title, :content,
                                   chapters_attributes: [:title, :row_order_position, :_destroy, :id],
                                   book_tags_attributes: [:book_id, :tag_id, :_destroy, :id])
    end

    def set_book
      @book = Book.includes(:book_tags => :tag).find(params[:id])
      authorize @book
    end

    def authorize_book
      authorize Book
    end
end
