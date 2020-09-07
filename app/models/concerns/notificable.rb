module Notificable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :item, dependent: :destroy
    after_commit :send_notifications_to_users, on: :update
    after_create :send_notifications_to_manager
  end

  def send_notifications_to_users
    NotificationSenderJob.perform_now self
  end

  def send_notifications_to_manager
    NotificationReceiverJob.perform_now(self) if respond_to? :send_to_manager
  end
end
