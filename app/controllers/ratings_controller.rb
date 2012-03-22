class RatingsController < ApplicationController
	before_filter :login_required
	
	def create
    @rating = Rating.new(params[:rating])
    if @rating.save
      flash[:notice] = "Post has been rated!" 
      redirect_to(:back)
    end
  end
end
