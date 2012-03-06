class MicropostMailer < ActionMailer::Base
  default :from => "support@truthpage.me"
  
  def post_email(micropost)
    @micropost = Micropost
    mail(:to => @micropost.user.email, :subject => "You have a new truth on truthpage.me!")  
  end
end
