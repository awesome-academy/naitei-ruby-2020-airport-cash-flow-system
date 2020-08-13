class RequestsController < ApplicationController
  def index
    @requests = Request.page(params[:page]).per Settings.items_per_pages
    @page = params[:page].nil? ? 1 : params[:page].to_i
  end
end
