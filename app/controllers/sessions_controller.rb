class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end