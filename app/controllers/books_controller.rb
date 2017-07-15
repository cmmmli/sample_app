class BooksController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :set_book, only: [:show, :destroy, :edit, :update]
  before_action :authorize_book, only: [:index, :new, :create]

  def index
    @books = Book.all.paginate(page: params[:page])
  end

  def show
    @chapters = @book.chapters
    @users = @book.users
  end

  def new
    @book = Book.new
    @book.chapters.build
  end

  def create
    @book = Book.new(book_params)
    @book.chapters.each_with_index do |chapter, i|
      chapter.add_chapter_num(i + 1)
    end
    if @book.save
      current_user.register_book_as_owner(@book)
      redirect_to book_url(@book)
    else
      render 'new'
    end
  end

  def edit
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

  private
    def book_params
      params.require(:book).permit(:title, :content,
                                   chapters_attributes: [:title, :chapter_num, :_destroy, :id])
    end

    def set_book
      @book = Book.find(params[:id])
      authorize @book
    end

    def authorize_book
      authorize Book
    end
end
