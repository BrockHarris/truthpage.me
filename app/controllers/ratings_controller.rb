class RatingsController < ApplicationController
	before_filter :login_required
	
	def create
    @rating = Rating.new(params[:rating])
    if @rating.save
      flash[:notice] = "Your rating has been posted" 
      redirect_to(:back)
    end
  end
end
