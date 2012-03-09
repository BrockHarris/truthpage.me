class MicropostMailer < ActionMailer::Base
  default :from => "support@truthpage.me"
  
  def post_email(micropost)
    @micropost = micropost
    @url  = "http://truthpage.me/#{@micropost.target_user.username}"
    mail(:to => @micropost.target_user.email, :subject => "You have a new truth on truthpage.me!")

  end
end
