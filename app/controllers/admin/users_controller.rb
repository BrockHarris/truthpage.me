class Admin::UsersController < ApplicationController
  before_filter :require_admin

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    opts = {}
    if User.destroy(@user)
      opts = {:notice=>"User destroyed successfully."}
    else
      opts = {:error=>"Unable to destroy user."}
    end
    redirect_to admin_users_path, opts
  end

end