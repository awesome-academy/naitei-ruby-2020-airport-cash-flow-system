class RequestsController < ApplicationController
  before_action :logged_in?, only: %i(create new)

  def index
    @requests = Request.by_status_and_datetime.page(params[:page]).per Settings.pagination.items_per_pages
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end

  def new
    @request = Request.new
    @request.request_details.new
  end

  def create
    @request = Request.new request_params

    if @request.save
      flash[:success] = t ".request_created"
      redirect_to root_url
    else
      flash[:error] = t ".request_failed"
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit Request::REQUEST_PARAMS
  end
end
