class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :find_user, :only=>[:show,:following, :followers, :follow, :unfollow, :edit, :update, :destroy]

  def index
    @title = "All users"
    #@users = User.paginate(:page => params[:page])   
    @usersearch = User.search(params[:search])
    @usersearch = @usersearch - [current_user] #eliminate self from the result
    @users = @usersearch.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @microposts = Micropost.find_all_by_belongs_to_id(@user.id)
    @micropost  = current_user.microposts.build(params[:micropost])
    @title = @user.username
  end
   
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_url
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def newpost
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Truth posted!"
      redirect_to @user
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def following
    @title = "Following"
    #@user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    #@user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def follow
    #@user = User.find(params[:id])
    current_user.follow!(@user)
    redirect_to users_path, :notice=>"You're now following #{@user.username}"
  end

  def unfollow
    #@user = User.find(params[:id])
    current_user.unfollow!(@user)
    redirect_to users_path, :notice=>"You're no longer following #{@user.username}"
  end

  def edit
    #@user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to (:back)
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    #User.find(params[:id]).destroy
    User.destroy(@user)
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
  
  def deny_access
      redirect_to signin_path, :notice => "You need to sign in first!"
  end
  
  def authenticate
    deny_access unless current_user
  end

  def correct_user
    @user = find_user
    redirect_to(root_path) unless current_user==@user
  end
end