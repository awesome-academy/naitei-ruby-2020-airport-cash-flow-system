class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform item
    return unless item.rejected? || item.approved? || item.paid?

    Notification.create(item: item, user_id: item.user_id, viewed: false)
  end
end
