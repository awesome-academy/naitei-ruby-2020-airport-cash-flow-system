class CreateIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :incomes do |t|
      t.string :title
      t.text :content
      t.float :amount
      t.string :currency
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
    add_index :incomes, %i(user_id created_at)
  end
end
