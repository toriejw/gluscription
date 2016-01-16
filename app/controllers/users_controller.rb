class UsersController < ApplicationController

  def show
    if current_user
      @search_results = current_user.search_results
    else
      redirect_to root_path
    end
  end

end
