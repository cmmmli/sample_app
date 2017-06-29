class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy

  def create
    @group = Group.find(params[:group_id])
    @comment = @group.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comments created!"
      redirect_to group_url(@group)
    else
      render 'groups/show'
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to group_url(@group)
  end

  private
    def comment_params
      params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
