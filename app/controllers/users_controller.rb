class UsersController < ApplicationController

  def show
    if session[:user_id]
      @searches = current_user.searches
    else
      redirect_to root_path
    end
  end

end
