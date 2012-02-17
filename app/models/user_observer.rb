class UserObserver < ActiveRecord::Observer
  def after_create(user)
    if user.creator && user.creator.admin?
      #an admin created...nothing to do (yet)
    else
      #this was a signup -- send the notification.
      UserMailer.signup_notification(user).deliver
    end
  end
end
