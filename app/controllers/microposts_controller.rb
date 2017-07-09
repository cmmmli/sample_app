class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_micropost, only: [:destroy]
  before_action :authorize_micropost, only: [:create]


  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      if @micropost.reply?
        @micropost.make_reply
        flash[:success] = "reply created!"
        redirect_to micropost_url(@micropost)
      else
        flash[:success] = "Micropost created!"
        redirect_to root_url
      end
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
    @to_micropost = Micropost.find(params[:id])
    @after_replies = @to_micropost.mentioned
    if @to_micropost.reply?
      @before_replies = @to_micropost.collect_go_back_replies
      # logger.info "MicropostsController#show - before_replies: #{@before_replies}"
    end
    @micropost = Micropost.new
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
