class SearchesController < ApplicationController

  respond_to :html, :xml, :json

  def new
  end

  def create
    @search_results = Search.return_results(params[:drug])

    if @search_results.found?
      Search.save(@search_results)
      respond_with_results(@search_results)
    else
      respond_with_not_found(@search_results)
    end
  end

  private

    def respond_with_results(search_results)
      respond_with do |format|
        format.html { render partial: "drugs/drug",
                             locals: { drug: @search_results },
                             layout: false }
      end
    end

    def respond_with_not_found(search_results)
      respond_with do |format|
        format.html { render json: Search.not_found_notice }
      end
    end

end
