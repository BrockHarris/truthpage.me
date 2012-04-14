class NotificationMailer < ActionMailer::Base
  default :from => "notifications@truthpage.me"
  
	def truth_request_email(notification)
    @mailer_sender = notification.sender.username
    @notification = notification
    @url  = "http://truthpage.me/#{@mailer_sender}"
    @settings_url  = "http://truthpage.me/users/#{@notification.receiver.username}/edit"

    mail(:to => @notification.receiver.email, :subject => "You have a truth request on truthpage.me")
  end
  def comment_email(notification)
    @mailer_sender = "self"

    @url  = "http://truthpage.me/"
    @settings_url  = "http://truthpage.me/users/edit"

    mail(:to => self.receiver.email, :subject => "new comment")
  end
end
