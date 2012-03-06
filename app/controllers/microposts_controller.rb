class MicropostsController < ApplicationController
  #skip_before_filter :verify_authenticity_token
  before_filter :login_required, :except=>[:create_pending]
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      MicropostMailer.post_email(@micropost).deliver
      flash[:notice] = "Your truth has been sent!"
      redirect_to(:back)
    else
      @feed_items = []
      flash[:alert] = "You haven't written anything!"
      redirect_to(:back)
    end
  end

  def create_pending
    #add basic micropost data into a session variable from ajax call so it can be referenced for creation
    #of a micropost after authentication.
    session[:pending_micropost] = nil
    if !current_user && params[:micropost][:content].present?
      session[:pending_micropost] = {:content=>params[:micropost][:content], :belongs_to_id=>params[:micropost][:belongs_to_id], :anon=>params[:micropost][:anon]}
    end
    render :nothing=>true
  end
 
  def destroy
    Micropost.find(params[:id]).destroy
    flash[:alert] = "Your post has been removed."
    redirect_to(:back)
  end
end