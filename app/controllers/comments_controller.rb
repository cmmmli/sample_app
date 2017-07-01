class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_group
  before_action :set_comment, only: :destroy
  before_action :authorize_comment, only: :create

  def create
    @comment = @group.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comments created!"
      redirect_to group_url(@group)
    else
      render 'groups/show'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to group_url(@group)
  end

  private
    def comment_params
      params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_comment
      @comment = current_user.comments.find_by(id: params[:id])
      authorize @comment
    end

    def authorize_comment
      redirect_to group_url(@group) unless @group.users.include?(current_user)
      authorize Comment
    end
end
