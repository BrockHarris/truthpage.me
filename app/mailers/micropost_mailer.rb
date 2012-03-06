class MicropostMailer < ActionMailer::Base
  default from: "support@truthpage.me"
  
  def post_email(micropost)
    @micropost = micropost
    @url  = "http://truthpage.me/signup"
    mail(:to => @micropost.target_user.email, :subject => "You have a new truth on truthpage.me!")
  end
end
