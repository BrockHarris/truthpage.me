class SessionsController < ApplicationController
#skip_before_filter :verify_authenticity_token

  def new
    @title = "Truthpage.me | Sign up"
    @user = User.new
    redirect_to root_url if current_user
  end

  def JSnew
    @title = "Truthpage.me | Sign up"
    @user = User.new
    redirect_to root_url if current_user
    @skip_render = true
    render :layout => false
  end

  def JScreate
    @title = "Truthpage.me | Sign up"
    @user = User.new
    redirect_to root_url if current_user
    @skip_render = true
    render :layout => false
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      unless notifications.empty?
        flash[:notice] = "Welcome back #{user.username}! <br/> You have #{notifications.count} new notifications.".html_safe
      else
        flash[:notice] = "Welcome back #{user.username}!".html_safe
      end
      if micropost = handle_pending_micropost
        flash[:notice] << "<br/>Truth posted!".html_safe
        redirect_to micropost.target_user
      else
        redirect_back_or_default(current_user)
      end
    else
      flash[:error] = "There was a problem with your email or password"
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_url
  end

  def sign_in_and_redirect_back_or_default(user, url=request.url)
    session[:user_id] = user.id
    redirect_back_or_default(url)
  end

end