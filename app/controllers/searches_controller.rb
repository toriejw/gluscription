class SearchesController < ApplicationController

  respond_to :html, :xml, :json

  def new
  end

  def create
    @drug = Drug.new(params[:drug])

    if @drug.found?
      current_user.save_search(@drug) if current_user

      respond_with do |format|
        format.html do
          render partial: "drugs/drug", locals: { drug: @drug }, layout: false
        end
      end
    else
      respond_with do |format|
        format.html do
          render json: "<p class='not-found-notice'>Sorry, we could not find the medication you searched for.</p>"
        end
      end
    end
  end

end
