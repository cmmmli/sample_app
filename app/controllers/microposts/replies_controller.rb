class Microposts::RepliesController < ApplicationController
  def new
    @to_micropost = Micropost.find(params[:micropost_id])
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      @micropost.make_reply(@mentioned_id) if @micropost.reply?
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  private

    def micropost_params
      @mentioned_id = params[:micropost_id]
      params.require(:micropost).permit(:content, :picture)
    end
end
