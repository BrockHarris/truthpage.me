class AuthenticationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :login_required, :only=>[:destroy]
  
  def index
   @authentications = current_user.authentications if current_user	
  end
  
  def create
    @omniauth = request.env["omniauth.auth"]
    authentication = Authentication.where(:provider=>@omniauth['provider'],:uid=>@omniauth['uid']).where("user_id IS NOT NULL").first
    if authentication
      flash[:notice] = "Welcome to truthpage.me! We reccomend using Google Chrome or Safari for this site."
      sign_in_and_redirect_back_or_default(authentication.user, user_path(authentication.user))
    elsif current_user
      #the user is logged in and trying to add another authentication (we don't support this...yet.)
      current_user.authentications.create(:provider => @omniauth['provider'], :uid => @omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      #User is attempting a signup using a service.
      if user = User.find_by_email(@omniauth[:info][:email])
        #if the user's email exists in our app, notify and redirect to signin. (They can add an auth after login - when we hook it up.)
        handle_authentication_email_conflict
      elsif user = User.find_by_username(@omniauth[:info][:nickname])
        #else if the user's username exists in our app, redirect to a page where they can submit their truthapp username.
        handle_authentication_username_conflict
      else
        #else create the user with this username and email, associate auth and sign them in. 
        handle_new_user_creation_through_authentication
      end  
    end
  end

  #this controller action will attempt to create a new user and associate the authentication record in session.
  def complete_session_authentication
    raise 'No authentication in session' unless session[:pending_authentication_id]
    @user = User.new(params[:user])
    if @user.save
      @user.authentications << Authentication.find(session[:pending_authentication_id])
      session[:pending_authentication_id] = nil #nix the id in session after successful assoc
      sign_in_and_redirect_back_or_default(@user, user_path(@user))
    else
      render :action=>"incomplete_authorization"
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

  private

  def handle_authentication_username_conflict
    flash.now[:notice]="Username #{@omniauth[:info][:nickname]} is already taken, please create an alternate for your truthpage account."
    #create an authorization object and store the id in session
    session[:pending_authentication_id] = Authentication.create!(:provider => @omniauth['provider'], :uid =>@omniauth['uid'])
    @user = User.new(:email=>@omniauth[:info][:email]) #create a user object for the form we're about to render.
    render :action=>"incomplete_authorization"
  end

  def handle_authentication_email_conflict
    flash[:notice]="#{@omniauth[:info][:email]} already has an account, signin using your password below."
    redirect_to(signin_path(:email=>user.email))
  end

  def handle_new_user_creation_through_authentication
      username = @omniauth['info']['nickname'] || @omniauth['info']['name']
      user = User.new(:mode=>"service", :email=>@omniauth['info']['email'], :username=>username.gsub(/\W/,''))
      user.authentications.build(:provider => @omniauth ['provider'], :uid => @omniauth['uid'])
      user.save!
      sign_in_and_redirect_back_or_default(user, user_path(user))
  end

end
