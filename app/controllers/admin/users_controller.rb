class Admin::UsersController < ApplicationController

  before_filter :admin_login_required
  before_filter :find_user, :except=>[:index]

  def index
    @facebook_users = User.all(:conditions => "facebook_id IS NOT NULL",)
    @users = User.order('created_at DESC').all.paginate(:page => params[:page], :per_page => 40)
    @microposts  = Micropost.all
    @title = "Truthpage | Admin"
  end

  def destroy
    @user = User.find_by_username(params[:id])
    opts = {}
    begin
      User.destroy(@user)
      opts = {:notice=>"User deleted successfully."}
    rescue Exception=>e
      opts = {:error=>"Unable to delete user. #{e.message}"}
    ensure
      redirect_to admin_users_path, opts
    end
  end
  private
 
  def find_user
     @user = User.find_by_username(params[:id])
   end
end