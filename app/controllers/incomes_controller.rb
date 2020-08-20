class IncomesController < ApplicationController
  def index
    @incomes = Income.page(params[:page]).per Settings.pagination.income
    @page = params[:page].nil? ? Settings.pagination.default_page : params[:page].to_i
  end
end
