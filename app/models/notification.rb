class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :item, polymorphic: true

  after_create{NotificationBroadcastJob.perform_later(self)}

  scope :lastest, ->{order created_at: :desc}
  scope :unviewed, ->{where viewed: false}
  scope :notification_user, ->(user_id){where user_id: user_id}

  class << self
    def for_user user_id
      Notification.where(user_id: user_id).unviewed.size
    end

    def mark_all_as_read user_id
      Notification.where(user_id: user_id).update viewed: true
    end
  end
end
