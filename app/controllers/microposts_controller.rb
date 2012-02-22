class MicropostsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :login_required
  
  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:notice] = "Your truth has been sent!"
      redirect_to(:back)
    else
      @feed_items = []
      render 'pages/home'
    end
  end
 
  def destroy
    Micropost.find(params[:id]).destroy
    flash[:alert] = "Your post has been removed."
    redirect_to(:back)
  end
end