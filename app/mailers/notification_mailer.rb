class NotificationMailer < ActionMailer::Base
  default :from => "notifications@truthpage.me"
  
	def truth_request_email(notification)
    @sender = notification.sender
    @sender_url  = "http://truthpage.me/#{notification.sender.username}"
    @notification = notification
    @settings_url  = "http://truthpage.me/users/#{@notification.receiver.username}/edit"
    mail(:to => @notification.receiver.email, :subject => "You have a truth request on truthpage.me")
  end

  def comment_email(notification)
    @sender = notification.sender
    @sender_url  = "http://truthpage.me/#{notification.sender.username}"
    @notification = notification
    @url  = "http://truthpage.me/#{notification.receiver.username}"
    @settings_url  = "http://truthpage.me/users/#{notification.receiver.username}/edit"
    mail(:to => notification.receiver.email, :subject => "You have a new comment on truthpage.me")
  end

  def rating_email(notification)
    @sender = notification.sender
    @notification = notification
    @url = "http://truthpage.me/#{notification.receiver.username}"
    @sender_url  = "http://truthpage.me/#{notification.sender.username}"
    @settings_url  = "http://truthpage.me/users/#{notification.receiver.username}/edit"
    if notification.format == "liked a truth about you."
      mail(:to => notification.receiver.email, :subject => "#{notification.sender.username} liked a truth about you on truthpage.me")
    else
      mail(:to => notification.receiver.email, :subject => "#{notification.sender.username} disliked a truth about you on truthpage.me")
    end
  end
end
