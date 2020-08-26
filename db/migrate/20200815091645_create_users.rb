class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :role
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
    add_index :users, %i(email)
  end
end
