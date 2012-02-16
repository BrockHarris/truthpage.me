class PagesController < ApplicationController

  def home
    @title = "Home"
    @globalfeed_items = Micropost.all #TOFIX: This is going to be a BAD thing if there are millions of posts.
    if current_user
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
      @microfeed_items = Micropost.where(:user_id => current_user.id).limit(5)
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
