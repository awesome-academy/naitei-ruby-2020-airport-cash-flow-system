module NotificationsHelper
  # rubocop:disable Rails/OutputSafety
  def render_notifications notifications
    notifications.map do |notification|
      render "notifications/notification", notification: notification
    end.join("").html_safe
  end
  # rubocop:enable Rails/OutputSafety
end
