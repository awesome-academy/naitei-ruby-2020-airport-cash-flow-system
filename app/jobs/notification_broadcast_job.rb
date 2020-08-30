class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform notification
    notification_count = Notification.for_user notification.user_id
    broadcast_name = "notifications.#{notification.user_id}"
    params = {action: Settings.new_notification, count: notification_count}
    ActionCable.server.broadcast broadcast_name, params
  end
end
