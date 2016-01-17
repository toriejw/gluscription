class DrugsController < ApplicationController

  def show
    @drug = Drug.new(params[:drug])

    current_user.save_search(@drug) if current_user
  end

end
