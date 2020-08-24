module SupplierAction
  extend ActiveSupport::Concern

  included do
    before_action :able_to_update_supplier, only: %i(update edit)
  end

  def edit; end

  def update; end

  private

  def able_to_update_supplier
    @supplier = if current_user.accountmanager?
                  Supplier.find_by id: params[:id]
                elsif current_user.accountant?
                  able_to_update_supplier_for_accountant
                end

    return if @supplier.present?

    flash[:error] = t "shared.sup_not_found"
    redirect_to root_url
  end

  def able_to_update_supplier_for_accountant
    supplier = Supplier.find_by id: params[:id]
    accountant_suppliers = Supplier.own_supplier current_user.id
    accountant_suppliers.include?(supplier) ? supplier : nil
  end
end
