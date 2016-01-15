class UsersController < ApplicationController

  def show
    redirect_to root_path if !current_user
  end
  
end
