module RequestsHelper
  def sum_amount request
    request.request_details.group(:request_id).sum :amount
  end
end
