class MarkallasreadController < ApplicationController
  def update
    Notification.mark_all_as_read current_user.id
  end
end
