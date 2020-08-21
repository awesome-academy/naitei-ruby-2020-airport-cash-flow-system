class Manager::RequestsController < Manager::ApplicationController
  include RequestAction

  def index
    @requests = section_request.by_status_and_datetime.page(params[:page]).per Settings.pagination.items_per_pages
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end

  def show; end

  def update
    status_change = params[:request][:status_id]
    reason = params[:request][:reason]
    respond_to do |format|
      format.html{redirect_to manager_request_url}
      format.js
    end
    return if @request.update status_id: status_change, reason: reason

    flash[:error] = t ".require_reason"
    redirect_to root_url
  end

  private

  def section_request
    Request.find_requests_by_section(current_user.section_id).except_own_request current_user.id
  end
end
