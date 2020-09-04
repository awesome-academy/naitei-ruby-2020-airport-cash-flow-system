class Manager::RequestsController < Manager::ApplicationController
  include RequestAction

  before_action :search, only: :index

  def index
    @section_request_search_path = manager_requests_path
    @requests = request_list.page(params[:page]).per Settings.pagination.items_per_pages
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end

  def show; end

  def update
    status_change = params[:request][:status]
    reason = params[:request][:reason]
    respond_to do |format|
      format.html{redirect_to manager_request_url}
      format.js
    end
    return if @request.update status: status_change, reason: reason

    flash[:error] = t ".require_reason"
    redirect_to root_url
  end

  private

  def search
    @search_section_request = section_request.ransack params[:q]
  end

  def request_list
    @request_list = @search_section_request.result.distinct.by_status_and_datetime
  end

  def section_request
    Request.find_requests_by_section(current_user.section_id).except_own_request(current_user.id).except_cancel_request
  end
end
