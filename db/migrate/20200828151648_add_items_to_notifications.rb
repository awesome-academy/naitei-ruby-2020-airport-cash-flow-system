class AddItemsToNotifications < ActiveRecord::Migration[6.0]
  def up
    change_table :notifications do |t|
      t.references :item, polymorphic: true
    end
  end

  def down
    change_table :notifications do |t|
      t.remove_references :item, polymorphic: true
    end
  end
end
