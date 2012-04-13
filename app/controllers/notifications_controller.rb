class NotificationsController < ApplicationController
	before_filter :login_required
	
	def create
    @notification = Notification.new(params[:notification])
    if @notification.save
      NotificationMailer.truth_request_email(@notification).deliver
      flash[:notice] = "Your request has been sent!" 
      redirect_to(:back)
    end
  end
  def destroy
  	@notification = Notification.find(params[:id])
  	Notification.find(@notification).destroy
    redirect_to(:back)
  end
  def clear_all
    @notifications =  Notification.where(:receiver_id => current_user.id).all
    Notification.destroy(@notifications)  
    redirect_to(:back)
  end
end
