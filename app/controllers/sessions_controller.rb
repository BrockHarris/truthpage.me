class SessionsController < ApplicationController
skip_before_filter :verify_authenticity_token
  def new
    redirect_to root_url if current_user
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Welcome back!"
      redirect_back_or_default(root_url)
    else
      flash.now[:error] = "There was a problem with your email or password"
      render :action => 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_url
  end

end

def sign_in_and_redirect_back_or_default(user, url=request.url)
    session[:user_id] = user.id
    redirect_back_or_default(url)
end