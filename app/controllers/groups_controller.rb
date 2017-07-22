class GroupsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy, :members]
  before_action :set_group, only: [:show, :destroy, :members, :edit, :update]
  before_action :authorize_group, only: [:index, :new, :create]


  def index
    @groups = Group.all.paginate(page: params[:page])
  end

  def show
    @comment = @group.comments.build
    @comments = @group.comments.includes(:user).paginate(page: params[:page])
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
    @group.destroy
    flash[:success] = "Group deleted"
    redirect_to groups_url
  end

  def edit
  end

  def update
    if @group.update_attributes(group_params)
      flash[:success] = "group updated"
      redirect_to @group
    else
      render 'edit'
    end
  end

  def members
    @title = "Group members"
    @users = @group.users.paginate(page: params[:page])
  end

  private
  def group_params
    params.require(:group).permit(:name, :detail)
  end

  def set_group
    @group = Group.find(params[:id])
    authorize @group
  end

  def authorize_group
    authorize Group
  end
end
