class AddViewedToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :viewed, :boolean
  end
end
