class NotificationsController < ApplicationController
	before_filter :login_required

	def show
		@notifications = Notification.where(:receiver => current_user.id).limit(5)
	end
	
	def create
    @notification = Notification.new(params[:notification])
    @notifications = Notification.where(:receiver => current_user.id).limit(5)
    if @notification.save
      flash[:notice] = "Your request has been sent!" 
      redirect_to(:back)
    end
  end
end
