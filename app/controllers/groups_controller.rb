class GroupsController < ApplicationController
  def index
    @groups = Group.all.paginate(page: params[:page])
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users.paginate(page: params[:page])
  end

  def new
    @group = Group.new
    @user = current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      current_user.join_group_by_admin(@group.id)
      render 'show'
    else
      render 'new'
    end
  end

  def destroy

  end

  private
  def group_params
    params.require(:group).permit(:name, :detail)
  end
end
