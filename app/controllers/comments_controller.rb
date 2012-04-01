class CommentsController < ApplicationController

	def create
		@comment = Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = "Your comment has been posted!" 
      redirect_to(:back)
    end
	end

	def destroy

	end
end
