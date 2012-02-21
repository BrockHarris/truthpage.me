class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_uri
  include SimpleCaptcha::ControllerHelpers
  helper :all 
  helper_method :current_user
  
  def check_uri
      redirect_to request.protocol + "www." + request.host_with_port + request.request_uri if !/^www/.match(request.host)
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def store_location(url=request.url)
    session[:return_to] = url
  end

  def sign_in_and_redirect_back_or_default(user, url=request.url)
    session[:user_id] = user.id
    redirect_to root_url
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def login_required
    unless current_user
      store_location
      flash[:notice] = "You need to sign in first!"
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