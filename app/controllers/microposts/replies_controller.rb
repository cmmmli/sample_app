class Microposts::RepliesController < ApplicationController

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      if @micropost.reply?
        @micropost.make_reply(@mentioned_id)
        flash[:success] = "reply created!"
        redirect_to micropost_url(@mentioned_id)
      else
        flash[:success] = "Micropost created!"
        redirect_to root_url
      end
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  private

    def micropost_params
      @mentioned_id = params[:micropost_id] || params[:id]
      params.require(:micropost).permit(:content, :picture)
    end
end
