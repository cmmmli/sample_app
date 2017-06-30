class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers, :notifications]
  after_action :notification_was_open, only: :notifications
  before_action :set_user, only: [:show, :edit, :update, :destroy, :notifications,
                                  :following, :followers]
  before_action :authorize_user, only: [:index, :new, :create]
  after_action :verify_authorized


  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def notifications
      @title = "Notifications"
      @users = @user.following unless @user.following.any?
      @notifications = current_user.notifications.paginate(page: params[:page])
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :screen_name)
    end

    # before_action

    def set_user
      @user = User.find(params[:id])
      authorize @user
    end

    def authorize_user
      authorize User
    end

    # after_action

    def notification_was_open
      @notifications = current_user.notifications.select{|n| n.opened == false}
      @notifications.each do |n|
        n.opened = true
        n.save
      end
    end
end
