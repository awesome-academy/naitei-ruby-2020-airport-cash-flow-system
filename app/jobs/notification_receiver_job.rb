class NotificationReceiverJob < ApplicationJob
  queue_as :default

  def perform item
    if item.user.manager?
      item.send_to_accountant.each do |accountant|
        Notification.create item: item, user_id: accountant.id, viewed: false
      end
    else
      item.send_to_manager.each do |manager|
        Notification.create item: item, user_id: manager.id, viewed: false
      end
    end
  end
end
