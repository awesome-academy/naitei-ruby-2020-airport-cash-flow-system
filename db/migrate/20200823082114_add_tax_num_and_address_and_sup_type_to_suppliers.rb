class AddTaxNumAndAddressAndSupTypeToSuppliers < ActiveRecord::Migration[6.0]
  def change
    add_column :suppliers, :taxNum, :string
    add_column :suppliers, :address, :string
    add_column :suppliers, :sup_type, :boolean
  end
end
