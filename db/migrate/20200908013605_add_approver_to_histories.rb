class AddApproverToHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :histories, :approver, :string
  end
end
