class Admin::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :admin_login_required
  before_filter :find_user, :except=>[:index]

  def index
    @users = User.all.paginate(:order => 'id DESC', :page => params[:page], :per_page => 40)
    @microposts  = Micropost.all
    
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
     @user = User.find_by_username(params[:id, :order => 'id DESC'])
   end
end