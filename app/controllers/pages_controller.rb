class PagesController < ApplicationController

  def home
    @title = "Truthpage.me"
    @globalfeed_items = Micropost.all #TOFIX: This is going to be a BAD thing if there are millions of posts.
    if current_user
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 20)
      @microfeed_items = Micropost.where(:user_id => current_user.id).limit(5)
    end
  end
  
  def legal
    @title = "Truthpage.me | legal"
  end

  def privacy
    @title = "Truthpage.me | privacy"
  end

  def terms
    @title = "Truthpage.me | terms of use"
  end
  
  def about
    @title = "Truthpage.me | about"
  end

end
