class Accountant::IncomesController < Accountant::ApplicationController
  before_action :fetch_currencies, only: %i(create new)
  before_action :fetch_suppliers, only: %i(create new)

  def index
    @incomes = Income.by_status_then_created_at.page(params[:page]).per Settings.pagination.items_per_pages
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end

  def new
    @income = Income.new
  end

  def create
    @income = Income.new income_params
    if @income.save
      flash[:success] = t ".success_mess"
      redirect_to accountant_incomes_path
    else
      flash[:error] = t ".fail_mess_create"
      render :new
    end
  end

  private

  def income_params
    params.require(:income).permit(Income::INCOMES_PARAMS).merge user_id: current_user.id, status_id: Settings.pending
  end

  def fetch_suppliers
    @suppliers = Supplier.sort_by_name
  end

  def fetch_currencies
    @currencies = Currency.all
  end
end
