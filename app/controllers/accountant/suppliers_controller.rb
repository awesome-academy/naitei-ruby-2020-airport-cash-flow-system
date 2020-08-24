class Accountant::SuppliersController < Accountant::ApplicationController
  include SupplierAction

  def index
    @suppliers = Supplier.sort_by_created_at.page(params[:page]).per Settings.pagination.items_per_pages
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new supplier_params.merge user_id: current_user.id
    if @supplier.save
      flash[:success] = t ".success_mess"
      redirect_to accountant_suppliers_path
    else
      flash[:error] = t ".fail_mess_create"
      render :new
    end
  end

  def edit; end

  def update
    if @supplier.update supplier_params
      flash[:success] = t ".success_mess"
      redirect_to accountant_suppliers_path
    else
      flash[:error] = t ".fail_mess"
      render :edit
    end
  end

  private

  def supplier_params
    params.require(:supplier).permit Supplier::SUPPLIERS_PARAMS
  end
end
