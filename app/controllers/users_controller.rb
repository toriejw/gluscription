class UsersController < ApplicationController

  def show
    if current_user
      @searches = current_user.searches
    else
      redirect_to root_path
    end
  end

end
