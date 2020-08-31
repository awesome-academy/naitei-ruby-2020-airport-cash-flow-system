class NotificationsController < ApplicationController
  before_action :get_notification_by_id, only: :update

  def index
    @notifications = Notification.notification_user(current_user.id).unviewed.lastest
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @notification.update viewed: true
      if current_user.manager?
        redirect_to manager_request_path @notification.item
      else
        redirect_to request_path @notification.item
      end
    else
      redirect_to root_url
    end
  end

  private

  def get_notification_by_id
    @notification = Notification.find_by id: params[:id]
  end
end
