class Accountant::RequestsController < Accountant::ApplicationController
  include RequestAction

  before_action :search, only: :index

  def index
    @requests = @search_accountant_request.result.distinct.page(params[:page]).per Settings.pagination.items_per_pages
    @accountant_request_search_path = accountant_requests_path
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end

  def show; end

  def update
    status = params[:request][:status]
    approver = params[:request][:approver]
    reason = params[:request][:reason]
    reject_request status, reason if status == status_rejected

    paid_request status, approver if status == status_paid

    respond_to do |format|
      format.html{redirect_to manager_request_url}
      format.js
    end
  end

  private

  def status_rejected
    Request.statuses.key(Settings.status.request.rejected)
  end

  def status_paid
    Request.statuses.key(Settings.status.request.paid)
  end

  def request_for_accountant
    Request.approved_requests.or(Request.paid_requests).by_status_and_datetime
  end

  def reject_request status_change, reason
    return if @request.update status: status_change, reason: reason

    flash[:error] = t ".require_reason"
    redirect_to root_url
  end

  def paid_request status_change, approver
    @request.paid_request! status_change, @request, approver
  end

  def search
    @search_accountant_request = request_for_accountant.ransack params[:q]
  end
end
