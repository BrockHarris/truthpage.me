class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
      user = User.authenticate(params[:session][:email],
                               params[:session][:password])
      if user.nil?
        flash.now[:error] = "Invalid email/password combination."
        @title = "Sign in"
        render 'new'
      else
        sign_in user
        redirect_back_or user
      end
  end
  
  def omnicreate

    data = request.env['omniauth.auth'] # here is all the user data
    if params[:provider] == 'twitter'
       #parse twitter data
    elsif params[:provider] == 'facebook'
       #parse fb data
    else
       # something is broken
       redirect_to '/404.html'
    end

    user = User.create! #use data you parsed to create a user
    redirect_to some_path, :notice => 'awwww yeah'
  end

  def destroy
        sign_out
        redirect_to root_path
  end
end


