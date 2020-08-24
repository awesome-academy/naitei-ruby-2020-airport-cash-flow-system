class AddTaxNumAndAddressAndTypeToSuppliers < ActiveRecord::Migration[6.0]
  def change
    add_column :suppliers, :taxNum, :int
    add_column :suppliers, :address, :string
    add_column :suppliers, :type, :boolean
  end
end
