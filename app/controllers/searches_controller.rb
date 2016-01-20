class SearchesController < ApplicationController

  respond_to :html, :xml, :json

  def new
  end

  def show
    @drug = Drug.new(params[:drug])
    current_user.save_search(@drug) if current_user
  end

  def create
    @drug = Drug.new(params[:drug])

    if @drug.found?
      current_user.save_search(@drug) if current_user

      respond_with do |format|
        format.html do
          if request.xhr?
            render partial: "drugs/drug", locals: { drug: @drug }, layout: false
          else
            redirect_to result_path
          end
        end
      end
    else
      respond_with do |format|
        format.html do
          if request.xhr?
            render json: "<p class='not-found-notice'>Sorry, we could not find the medication you searched for.</p>"
          else
            render action: :new
          end
        end
      end
    end
  end

end