class DrugsController < ApplicationController
  
  def show
    @drug = Drug.new(params[:drug])
  end

end
