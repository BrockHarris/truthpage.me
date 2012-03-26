class MicropostMailer < ActionMailer::Base
  default :from => "notifications@truthpage.me"
  
def post_email(micropost)
  if  micropost.try(:anon?)
  		@mailer_sender = "Someone anonymously"
  else
      @mailer_sender = micropost.user.username
  end
      @micropost = micropost
      @url  = "http://truthpage.me/#{@micropost.target_user.username}"
      @settings_url  = "http://truthpage.me/users/#{@micropost.target_user.username}/edit"
      mail(:to => @micropost.target_user.email, :subject => "You've received a new truth on truthpage.me!")
  end
end
