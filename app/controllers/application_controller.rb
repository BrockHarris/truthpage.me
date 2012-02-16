class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all # include all helpers, all the time
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def store_location(url=request.url)
    session[:return_to] = url
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def login_required(msg=MESSAGE_MUST_BE_LOGGED_IN)
    unless current_user
      store_location
      flash[:notice] = msg
      redirect_to signin_url
      return false
    end
  end

  def access_denied(msg=MESSAGE_INSUFFICIENT_RIGHTS)
    flash[:error] = msg
    redirect_to root_url
    return false
  end
  
  def admin_login_required
    access_denied unless current_user.try(:admin)
  end

end