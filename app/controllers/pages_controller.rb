class PagesController < ApplicationController
skip_before_filter :verify_authenticity_token
  def home
    @title = "Truthpage.me"
    @globalfeed_items = Micropost.limit(50) 
    if current_user
      @notifications = Notification.where(:receiver => current_user.username).limit(5)
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 20)
      @microfeed_items = Micropost.where(:user_id => current_user.id).limit(5)
    end
  end
  
  def legal
    @title = "Truthpage.me | Legal"
    if current_user
      @notifications = Notification.where(:receiver => current_user.username).limit(5)
    end
  end

  def privacy
    @title = "Truthpage.me | Privacy"
    if current_user
      @notifications = Notification.where(:receiver => current_user.username).limit(5)
    end
  end

  def terms
    @title = "Truthpage.me | Terms of use"
    if current_user
      @notifications = Notification.where(:receiver => current_user.username).limit(5)
    end
  end
  
  def help
    @title = "Truthpage.me | Help"
    if current_user
      @notifications = Notification.where(:receiver => current_user.username).limit(5)
    end
  end
  
  def about
    @title = "Truthpage.me | About"
    if current_user
      @notifications = Notification.where(:receiver => current_user.username).limit(5)
    end
  end

end
