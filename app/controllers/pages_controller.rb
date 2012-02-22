class PagesController < ApplicationController
skip_before_filter :verify_authenticity_token
  def home
    @title = "Truthpage.me"
    @globalfeed_items = Micropost.limit(50) 
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
