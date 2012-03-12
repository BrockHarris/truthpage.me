class NotificationsController < ApplicationController
	before_filter :login_required
	
	def create
    @notification = Notification.new(params[:notification])
    if @notification.save
      flash[:notice] = "Your request has been sent!" 
      redirect_to(:back)
    end
  end
end
