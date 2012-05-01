class PagesController < ApplicationController
skip_before_filter :verify_authenticity_token
  def home
    @faces = User.created_order.all(:limit => 16)
    @users = User.all
    @title = "Truthpage.me"
    if current_user
      if current_user.background.exists?
         @user = current_user 
         @user_custom_background = true
      end
      @title = "Truthpage.me | Friends"
      @rating = Rating.new(params[:rating])
      @micropost = Micropost.new
      @followers = current_user.following
      unless current_user.authentications.empty?
        @fb_user = FbGraph::User.me(current_user.token)
        @facebook_friends = @fb_user.friends.map &:identifier
        @registered_friends = User.where("facebook_id IN (?)", @facebook_friends)
        @fb_truths = Micropost.where("belongs_to_id IN (?)", @registered_friends)
      end
      if @followers.count > 2
        @feed_items = Micropost.order.where("belongs_to_id IN (?)", @followers).paginate(:page => params[:page], :per_page => 20)
      elsif current_user.authentications.empty?
        @feed_items = Micropost.order.where("belongs_to_id IN (?)", @followers).paginate(:page => params[:page], :per_page => 20)
      else
        @feed_items = Micropost.where("belongs_to_id IN (?)", @registered_friends).paginate(:page => params[:page], :per_page => 20)
        @change_feed_header = true
      end
    end
  end
  
  def welcome_page
    @title = "Welcome!"
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
