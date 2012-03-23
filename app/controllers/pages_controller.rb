class PagesController < ApplicationController
skip_before_filter :verify_authenticity_token
  def home
    @title = "Truthpage.me | Friends"
    if current_user
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 20)
      @fbfeed_items = Micropost.where(:belongs_to_id => current_user.id).limit(5)
      unless current_user.authentications.empty?
        @fb_user = FbGraph::User.me(current_user.token)
        @facebook_friends = @fb_user.friends.map &:identifier
        @registered_friends = User.where("facebook_id IN (?)", @facebook_friends)
      end
    end
  end
  
  def legal
    @title = "Truthpage.me | Legal"
  end

  def privacy
    @title = "Truthpage.me | Privacy"
  end

  def terms
    @title = "Truthpage.me | Terms of use"
  end
  
  def help
    @title = "Truthpage.me | Help"
  end
  
  def about
    @title = "Truthpage.me | About"
  end

end
