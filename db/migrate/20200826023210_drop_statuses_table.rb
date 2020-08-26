class DropStatusesTable < ActiveRecord::Migration[6.0]
  def up
    remove_reference :incomes, :status, index: true, foreign_key: true
    drop_table :statuses
  end

  def down
    create_table :statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
