class Accountant::RequestsController < Accountant::ApplicationController
  include RequestAction

  def index
    @requests = request_for_accountant.page(params[:page]).per Settings.pagination.items_per_pages
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end

  def show; end

  def update
    status = params[:request][:status]
    reason = params[:request][:reason]
    reject_request status, reason if status == status_rejected

    paid_request status if status == status_paid

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

  def paid_request status_change
    @request.paid_request! status_change, @request
  end
end
