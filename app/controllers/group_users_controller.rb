class GroupUsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    current_user.join_group_by_member(@group.id)
    respond_to do |format|
      format.html {redirect_to @group}
      format.js
    end
  end

  def destroy
    @group = GroupUser.find(params[:id]).group
    current_user.defect(@group.id)
    respond_to do |format|
      format.html {redirect_to @group}
      format.js
    end
  end
end
