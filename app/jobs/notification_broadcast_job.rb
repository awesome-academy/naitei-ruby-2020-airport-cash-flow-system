class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform notification
    notification_count = notification.user.notifications_unviewed.size
    broadcast_name = "notifications.#{notification.user_id}"
    params = {action: Settings.new_notification, count: notification_count}
    ActionCable.server.broadcast broadcast_name, params
  end
end
