class UsersController < ApplicationController
  before_filter :login_required, :only => [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  before_filter :find_user, :only=>[:show, :following, :followers, :follow, :unfollow, :edit, :update, :destroy]
  before_filter :admin_user,   :only => :destroy
  
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
    if simple_captcha_valid?
      if @user.save
        #skip sending a registration email, explicitly activate user, sign-in and redirect.
        #@user.register! #set status to pending
        #@user.send_activation_email!
        #flash[:notice] = "Thanks for signing up! An email has been sent to #{@user.email} with instructions on how to immediately activate your account."
        @user.activate!
        flash[:notice] = "Thanks for signing up!"
        sign_in_and_redirect_back_or_default(@user, users_path(@user))
      else
        render :action => 'new'
      end
    else
       flash[:error] = "captcha invalid"
       render :action => 'new'
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
    flash[:success] = "removed truthpage user."
    redirect_to users_path
  end

  # If the request's HTTP method was +post+ and a parameter named +email+ is
  # submitted, looks up the corresponding user and, if found, sends a password
  # reset email.
  def welcome
    if @user.nil? || (!@user.active? && !@user.pending?)
      flash.now[:error] = "This user is no longer available for this operation."
    else
      @user.send_welcome_email!
      flash[:notice] = "An email has been sent to #{@user.email}."
    end
    redirect_to users_path
  end


  # Activates the user if the user's state is pending and the correct
  # activation code is submitted as a parameter named +activation_code+.
  # The request is redirected in all cases.
  def activation
    #logout_keeping_session!
    @user = User.find_by_id(params[:id])
    code = params[:activation_code]
    case when @user && @user.pending? && @user.activation_code == code
      User.transaction do
        @user.activate!
      end
      flash[:notice] = "Your account is activated! Please log in to continue."
      redirect_to signin_url
    when @user && @user.active?
      flash[:notice] = "Your account is already activated. Please sign in to continue."
      redirect_to signin_url
    else
      flash[:alert]  = "Invalid activation code. Please cut and paste the URL into your browser. If you continue to have trouble, please contact us at #{SUPPORT_EMAIL}."
      redirect_to signin_url
    end
  end

  # If the request's HTTP method was +post+ and a parameter named +email+ is
  # submitted, looks up the corresponding user and, if found, sends a password
  # reset email.
  def assist
    @email = params[:email]
    if request.post? && !@email.blank?
      user = User.find_by_email(@email)
      if user.nil? || (!user.active? && !user.pending?)
        flash.now[:error] = "We don't have an active account for '#{@email}'. Please try again, or contact us at #{SUPPORT_EMAIL} if you need assistance."
      else
        user.send_reset_password_email!
        flash[:notice] = "An email has been sent to #{@email}.<br />".html_safe
        flash[:notice] << "Follow the instructions in the email to reset your password."
        redirect_to signin_url
      end
    end
  end

  def reset
    @user = User.find_by_id(params[:id])
    code = params[:reset_code]
    if request.post?
      if !params[:password].nil?
        @user.password = params[:password]
        @user.password_confirmation = params[:password_confirmation]

        # If the password has already been set, this doesn't normally cause
        # a validation error, but we want it to here.
        if @user.valid? && @user.password.blank?
          @user.errors.add(:password, ActiveRecord::Errors.default_error_messages[:blank])
        end

        if @user.errors.empty?
          @user.reset_code = nil
          @user.reset_code_at = nil
          @user.save!
          if @user.pending?
            User.transaction do
              @user.activate!
            end
          end
          flash[:notice] = "Your password has been changed. Please log in to continue."
          redirect_to signin_url
        end
      else
        render :action=>"reset"
      end
    elsif request.get?
      if @user.blank? || code.blank?
        flash[:error] = "The link from your password reset may have been cut off. Try to copy and paste the entire URL into your browser, or send a new email below. Please contact us at #{SUPPORT_EMAIL} if you continue to have trouble."
        redirect_to assist_url
        return
      end
    end
  end


  #a hard link to activate a user.
  def activate
    @user.activate! if @user.pending?
    redirect_to root_url
  end

  private
  
  def admin_user
        redirect_to(root_path) if current_user = current_user.admin
  end
  
  def find_user
    @user = User.find_by_username(params[:id])
  end
  
  def correct_user
    @user = find_user
    redirect_to(root_path) unless current_user==@user
  end
end