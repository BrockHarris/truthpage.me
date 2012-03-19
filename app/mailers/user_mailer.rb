class UserMailer < ActionMailer::Base
  default :from=>"Truthpage.me <#{TRUTHPAGEME_EMAIL}>"

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