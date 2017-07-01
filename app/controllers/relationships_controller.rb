class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :set_relationship, only: :destroy
  before_action :authorize_relationship, only: :create

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  private
    def set_relationship
      @relationship = Relationship.find(params[:id])
      authorize @relationship
    end

    def authorize_relationship
      authorize Relationship
    end
end
