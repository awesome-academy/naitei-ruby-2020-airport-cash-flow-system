class AddStatusToIncomes < ActiveRecord::Migration[6.0]
  def change
    add_reference :incomes, :status, null: false, foreign_key: true
  end
end
