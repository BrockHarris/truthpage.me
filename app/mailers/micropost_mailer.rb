class MicropostMailer < ActionMailer::Base
  default from: "support@truthpage.me"
  
  def post_email(micropost)
    @micropost = micropost
    @user = User.find_by_username(params[:id])
    @url  = "http://truthpage.me/signup"
    mail(:to => @user.email, :subject => "You have a new truth on truthpage.me!")
  end
end
