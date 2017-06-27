class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show

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
