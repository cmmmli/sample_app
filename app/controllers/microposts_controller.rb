class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_micropost, only: [:destroy]
  before_action :authorize_micropost, only: [:create]
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
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


  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def set_micropost
      @micropost = Micropost.find(params[:id])
      authorize @micropost
    end

    def authorize_micropost
      authorize Micropost
    end
end
