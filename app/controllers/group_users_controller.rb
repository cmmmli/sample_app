class GroupUsersController < ApplicationController
  before_action :logged_in_user
  before_action :set_group_user, only: :destroy
  before_action :authorize_group_user, only: :create

  def create
    @group = Group.find(params[:group_id])
    current_user.join_group_by_member(@group.id)
    respond_to do |format|
      format.html {redirect_to @group}
      format.js
    end
  end

  def destroy
    @group = @group_user.group
    current_user.defect(@group.id)
    respond_to do |format|
      format.html {redirect_to @group}
      format.js
    end
  end

  private
    def set_group_user
      @group_user = GroupUser.find(params[:id])
      authorize @group_user
    end

    def authorize_group_user
      authorize GroupUser
    end
end
