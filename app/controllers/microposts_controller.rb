class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Truth posted!"
      redirect_to(:back)
    else
      @feed_items = []
      render 'pages/home'
    end
  end
  def show
  
  end
 
 
  def destroy
     @micropost.destroy
    redirect_back_or root_path
    end
end