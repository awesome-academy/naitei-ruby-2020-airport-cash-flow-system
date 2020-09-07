module NotificationsHelper
  # rubocop:disable Rails/OutputSafety
  def render_notifications notifications
    if notifications.blank?
      render "notifications/notification_empty"
    else
      notifications.map do |notification|
        render "notifications/notification", notification: notification
      end.join("").html_safe
    end
  end
  # rubocop:enable Rails/OutputSafety
end
