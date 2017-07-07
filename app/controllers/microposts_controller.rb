class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_micropost, only: [:destroy]
  before_action :authorize_micropost, only: [:create]


  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      @micropost.make_reply if @micropost.reply?
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_back(fallback_location: root_url)
  end

  def show
    @micropost = Micropost.find(params[:id])
  end


  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture, :destination)
    end

    def set_micropost
      @micropost = Micropost.find(params[:id])
      authorize @micropost
    end

    def authorize_micropost
      authorize Micropost
    end

end
