class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :item, polymorphic: true

  after_create{NotificationBroadcastJob.perform_now(self)}

  scope :lastest, ->{order created_at: :desc}
  scope :unviewed, ->{where viewed: false}
  scope :notification_user, ->(user_id){where user_id: user_id}
end
