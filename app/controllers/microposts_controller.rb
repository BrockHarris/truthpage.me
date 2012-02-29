class MicropostsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :login_required
  
  def create
     @micropost = current_user.microposts.build(params[:micropost])
     @user = User.find_by_username(params[:id])
     if @micropost.save
       #MicropostMailer.post_email(@user).deliver
       flash[:notice] = "Your truth has been sent!"
       redirect_to(:back)
     else
       @feed_items = []
       flash[:alert] = "You haven't written anything!"
       redirect_to(:back)
     end
   end
 
  def destroy
    Micropost.find(params[:id]).destroy
    flash[:alert] = "Your post has been removed."
    redirect_to(:back)
  end
end