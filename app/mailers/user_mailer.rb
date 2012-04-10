class UserMailer < ActionMailer::Base
  default :from => "notifications@truthpage.me"

  def signup_notification(user)
    @sent_on     = Time.now
    @user        = user
    mail(:to => ["#{TRUTHPAGEME_EMAIL}" , "btharris781@gmail.com"],
         :subject => "Truthpage.me: New User Signup")
  end

  def activation(user)
    @url  = activate_url(:host => SITE_URL_HOST, :id => user.id, :activation_code => user.activation_code)
    @user = user
    mail(
        :to => ["#{user.email}"],
        :subject => "Truthpage.me: Please activate your new account.")
  end
 
  def welcome(user)
    if user.pending? || user.active?
      @user = user
      @url  = reset_url(:id => user.id, :reset_code => user.reset_code, :host => SITE_URL_HOST)
      mail(
        :to => ["#{user.email}"],
        :subject => "Welcome to truthpage.me!")
    end
  end
  
  def new_follower_email(user, current_user)
    @follower = current_user.username
    @profile_url  = "http://truthpage.me/#{user.username}"
    @settings_url  = "http://truthpage.me/users/#{user.username}/edit"
    mail(:to => user.email, :subject => "You have a new follower on truthpage.me!")
  end

  # Sets up an email that gives the user instructions on how to reset the
  # password and provides a link to allow the user to reset the password.  
  def forgot(user)
    if user.pending? || user.active?
      @user = user
      @url        = reset_url(:id => user.id, :reset_code => user.reset_code, :host => SITE_URL_HOST)
      mail( 
          :to => ["#{user.email}"],
          :subject => "Truthpage.me: Reset your password.")
    end
  end
end