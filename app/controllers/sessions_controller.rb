class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
    end
    redirect_to profile_path
  end

  def destroy
    reset_session
    flash[:notice] = "You have successfully logged out."

    redirect_to root_path
  end
end
