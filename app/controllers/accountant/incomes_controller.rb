class Accountant::IncomesController < Accountant::ApplicationController
  def index
    @incomes = Income.page(params[:page]).per Settings.pagination.items_per_pages
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end
end
