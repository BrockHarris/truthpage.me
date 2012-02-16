class MicropostsController < ApplicationController
  before_filter :login_required
  
  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Truth posted!"
      redirect_to(:back)
    else
      @feed_items = []
      render 'pages/home'
    end
  end
 
  def destroy
    Micropost.find(params[:id]).destroy
    flash[:success] = "your post has been removed"
    redirect_to(:back)
  end
end