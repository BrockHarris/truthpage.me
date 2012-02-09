class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
   


  def index
     @title = "All users"
     #@users = User.paginate(:page => params[:page])   
     @usersearch = User.search(params[:search])
     @users = @usersearch.paginate(:page => 1, :per_page => 30)
  end
  
  def show
      @user = User.find(params[:id])
      @microposts = Micropost.find_all_by_belongs_to_id(@user.id)
      @micropost  = current_user.microposts.build(params[:micropost])
      @title = @user.name
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
            @user = User.find(params[:id])
            @users = @user.following.paginate(:page => params[:page])
            render 'show_follow'
      end

      def followers
            @title = "Followers"
            @user = User.find(params[:id])
            @users = @user.followers.paginate(:page => params[:page])
            render 'show_follow'
      end
      
      def edit
        @user = User.find(params[:id])
        @title = "Edit user"
      end
  
      def update
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated."

        redirect_to (:back)

      else
        @title = "Edit user"
        render 'edit'
      end
      
      def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User destroyed."
        redirect_to users_path
      end
    end
    
  

     private

         def authenticate
<<<<<<< HEAD
           deny_access unless signed_in?
=======
           deny_access unless current_user
>>>>>>> f9e9f1aea53163323cd86296b6826057ac1ec104
         end

         def correct_user
           @user = User.find(params[:id])
<<<<<<< HEAD
           redirect_to(root_path) unless current_user?(@user)
=======
           redirect_to(root_path) unless current_user==@user
>>>>>>> f9e9f1aea53163323cd86296b6826057ac1ec104
         end
     end