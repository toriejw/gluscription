class ResultsController < ApplicationController
  def show
  end

  def create
    @drug = Drug.new(params[:drug])
    redirect_to result_path
  end
end
