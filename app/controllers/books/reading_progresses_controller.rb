class Books::ReadingProgressesController < ApplicationController
  before_action :logged_in_user
  before_action :set_progress, only: :destroy
  before_action :authorize_progress, only: :create

  def create
    @book = BookUser.find(params[:book_user_id]).book
    @chapter = Chapter.find(params[:chapter_id])
    @book_user = BookUser.find(params[:book_user_id])
    @chapter.read(@book_user)
    respond_to do |format|
      format.html {redirect_to @book}
    end
  end

  def destroy
    @chapter = @reading_progress.chapter
    @book_user = @reading_progress.book_user
    @book = @book_user.book
    @chapter.unread(@book_user)
    respond_to do |format|
      format.html {redirect_to @book}
    end
  end

  private

    def set_progress
      @reading_progress = ReadingProgress.find(params[:id])
      authorize @reading_progress
    end

    def authorize_progress
      authorize ReadingProgress
    end
end
