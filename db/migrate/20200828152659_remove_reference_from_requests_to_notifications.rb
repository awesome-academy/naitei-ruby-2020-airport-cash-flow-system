class RemoveReferenceFromRequestsToNotifications < ActiveRecord::Migration[6.0]
  def up
    change_table :notifications do |t|
      t.remove_references :request, null: false, foreign_key: true
    end
  end

  def down
    change_table :notifications do |t|
      t.references :request, null: false, foreign_key: true
    end
  end
end
