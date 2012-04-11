class CommentsController < ApplicationController
  before_filter :find_micropost
	
  def create
		@comment = @micropost.comments.new(params[:comment])
    if @comment.save
      flash[:notice] = "Your comment has been posted!" 
      redirect_to(:back)
    end
	end

	def destroy
	end

  private

  def find_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end

end
