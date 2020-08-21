class CreateRequestDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :request_details do |t|
      t.float :amount
      t.string :description
      t.string :section_name
      t.references :request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
