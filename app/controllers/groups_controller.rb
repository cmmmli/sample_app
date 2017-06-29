class GroupsController < ApplicationController
  def index
    @groups = Group.all.paginate(page: params[:page])
  end

  def show
    @group = Group.find(params[:id])
    @comment = @group.comments.build
    @comments = @group.comments.paginate(page: params[:page])
  end

  def new
    @group = Group.new
    @user = current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      current_user.join_group_by_admin(@group.id)
      redirect_to group_url(@group)
    else
      render 'new'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = "Group deleted"
    redirect_to groups_url
  end

  def members
    @title = "Group members"
    @group = Group.find(params[:id])
    @users = @group.users.paginate(page: params[:page])
  end

  private
  def group_params
    params.require(:group).permit(:name, :detail)
  end
end
