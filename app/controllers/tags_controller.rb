class TagsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_tag, only: [:show, :destroy]
  before_action :authorize_tag, only: [:index, :create]

  def index
    @tags = Tag.all.paginate(page: params[:page])
  end

  def show
    @books = @tag.books.paginate(page: params[:page])
  end

  def create
  end

  def destroy
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
      authorize @tag
    end

    def authorize_tag
      authorize Tag
    end
end
