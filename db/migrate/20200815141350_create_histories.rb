class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.timestamp :paid_time
      t.references :request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
