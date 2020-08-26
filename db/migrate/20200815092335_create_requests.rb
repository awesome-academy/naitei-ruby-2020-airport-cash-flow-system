class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :title
      t.string :currency
      t.text :content
      t.text :reason
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :requests, %i(user_id created_at)
  end
end
