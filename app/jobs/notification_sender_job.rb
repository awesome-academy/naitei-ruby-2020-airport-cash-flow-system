class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform item
    return unless item.rejected? || item.approved? || item.paid?

    if item.approved?
      item.send_to_accountant.each do |accountant|
        Notification.create item: item, user_id: accountant.id, viewed: false
      end
    end
    Notification.create item: item, user_id: item.user_id, viewed: false
  end
end
