class AuthenticationsController < ApplicationController
  before_filter :login_required, :only=>[:destroy]
  
  def index
   @authentications = current_user.authentications if current_user	
  end
  
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect_back_or_default(authentication.user, user_path(authentication.user))
    elsif current_user
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      #User is attempting a signup using a service.
      #raise omniauth.to_yaml
      if user = User.find_by_email(omniauth[:info][:email])
        #see if the user's email exists in our app, if so, notify and redirect to signin.
        flash[:notice]="#{omniauth[:info][:email]} already has an account, signin using your password below."
        redirect_to(signin_path(:email=>user.email))
      elsif user = User.find_by_username(omniauth[:info][:nickname])
        #else see if the user's username exists in our app, if so, redirect to a page where they can submit their username
        flash[:notice]="#{omniauth[:info][:username]} is already taken, please create an alternate for your account."
        raise 'username exists'
      else
        #else create the user with this username and email, rand password, associate auth and sign them in. 
        raise "create a user and append an auth!"
        user = User.create_by_email_and_username(:email=>omniauth['info']['email'], :username=>omniauth['info']['nickname'] || omniauth['info']['name'])
        user.authentications.build(:provider => omniauth ['provider'], :uid => omniauth['uid'])
        user.save!
        sign_in_and_redirect_back_or_default(user, user_path(user))
      end  
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

  def sign_in_and_redirect_back_or_default(user, url=request.url)
    session[:user_id] = user.id
    redirect_back_or_default url
  end

end
