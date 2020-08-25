class RequestsController < ApplicationController
  include RequestAction

  def index
    @requests = get_own_request.page(params[:page]).per Settings.pagination.items_per_pages
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end

  def new
    @request = Request.new
    @request.request_details.new
  end

  def show; end

  def create
    @request = Request.new request_params

    if @request.save
      flash[:success] = t ".request_created"
      redirect_to request_path @request
    else
      flash[:error] = t ".request_failed"
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit Request::REQUEST_PARAMS
  end

  def get_own_request
    Request.own_request(current_user.id).by_status_and_datetime
  end
end
