class UsersController < ApplicationController

  def show
    redirect_to root_path if !current_user
    @search_results = current_user.search_results
  end

end
