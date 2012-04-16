class CommentsController < ApplicationController
  before_filter :find_micropost
  skip_before_filter :find_micropost, :only => :destroy
	
  def create
		@comment = @micropost.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Your comment has been posted!" 
      redirect_to(:back)
    end
	end

	def destroy
    @comment = Comment.find(params[:id])
    Comment.find(@comment).destroy
    flash[:notice] = "Your comment has been deleted." 
    redirect_to(:back)
	end

  private

  def find_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end

end
