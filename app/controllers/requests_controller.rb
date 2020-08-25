class RequestsController < ApplicationController
  include RequestAction

  before_action :able_to_edit, only: %i(update edit)

  def index
    @requests = get_own_request.page(params[:page]).per Settings.pagination.items_per_pages
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end

  def new
    @request = Request.new
    @request.request_details.new
  end

  def show; end

  def edit; end

  def update
    RequestDetail.where(request_id: params[:id]).destroy_all
    if @request.update request_params
      flash[:success] = t ".request_updated"
      redirect_to @request
    else
      flash[:danger] = t ".update_failed"
      render :edit
    end
  end

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

  def able_to_edit
    request = Request.find_by id: params[:id]

    return if request.is_pending? || current_user.is_manager? && request.is_approved?

    flash[:error] = t ".disable_edit"
    redirect_to root_url
  end
end
