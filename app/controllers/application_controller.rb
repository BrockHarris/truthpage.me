class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  #TODO: create some more robust authorization helpers or implement cancan
  def require_admin
    redirect_to root_path unless current_user.try(:admin)
  end

end