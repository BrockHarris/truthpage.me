class Admin::UsersController < ApplicationController
  before_filter :admin_login_required

  def index
    @users = User.all.paginate(:page=>params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    opts = {}
    begin
      User.destroy(@user)
      opts = {:notice=>"User destroyed successfully."}
    rescue Exception=>e
      opts = {:error=>"Unable to destroy user. #{e.message}"}
    ensure
      redirect_to admin_users_path, opts
    end
  end

end