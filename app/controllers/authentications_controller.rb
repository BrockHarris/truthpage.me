class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect_to(authentication.user, root_url)
    elsif current_user
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.omniauth_find_or_create(omniauth)
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect_to(user, root_url)
    end
  end

  def auth_failure
    flash[:error] = "Authentication Failed"
    redirect_to new_session_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end


  #quick and dirty devise-like helper.
  def sign_in_and_redirect_to(user, url)
    session.clear
    session[:user_id] = user.id
    redirect_to url
  end

end
