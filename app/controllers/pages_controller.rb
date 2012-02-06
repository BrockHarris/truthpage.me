class PagesController < ApplicationController
  def home
      @title = "Home"
      @globalfeed_items = Micropost.all
    if signed_in?
      
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
      @ownpost = Micropost.find_all_by_user_id(current_user.id)
  end
  
  
  end
  
  def new
    @user = User.new
  end
  
  def create
     
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
    
  end
  
  def contact
  @title = "contact"
  end

  def feedback
  @title = "feedback"
  end

  def privacy
  @title = "privacy"
  end

  def terms
  @title = "terms & conditions"
  end
  
  def help
  @title = "Help"
  end

end
