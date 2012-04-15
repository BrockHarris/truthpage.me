class MicropostMailer < ActionMailer::Base
  default :from => "notifications@truthpage.me"
  
 def post_email(micropost)
  @mailer_sender_url = "http://truthpage.me/#{micropost.user.username}"
  @mailer_sender = micropost.user.username
  @micropost = micropost
  @url  = "http://truthpage.me/#{@micropost.target_user.username}"
  @settings_url  = "http://truthpage.me/users/#{@micropost.target_user.username}/edit"
  mail(:to => @micropost.target_user.email, :subject => "You have a new truth on truthpage.me")
  end
end
