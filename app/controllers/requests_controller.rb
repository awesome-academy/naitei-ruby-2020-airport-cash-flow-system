class RequestsController < ApplicationController
  before_action :visible_request, only: :show

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

  def visible_request
    if current_user.is_accountant?
      @request = Request.find_by id: params[:id]
    elsif current_user.is_manager?
      @request = visible_request_for_manager
    elsif current_user.is_normal_user?
      @request = visible_request_for_user
    end

    return if @request.present?

    flash[:error] = t ".warning_msg"
    redirect_to root_url
  end

  def visible_request_for_manager
    request_params = Request.find_by id: params[:id]
    request_params.user.section_id == current_user.section_id ? request_params : nil
  end

  def visible_request_for_user
    user_requests = Request.own_request current_user.id
    @request = user_requests.include?(@request_params) ? request_params : nil
  end
end
