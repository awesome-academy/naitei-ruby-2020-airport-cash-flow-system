class Accountant::ApplicationController < ApplicationController
  before_action :require_accountant

  def home; end

  private

  def require_accountant
    return if current_user.accountant?

    redirect_to root_path, flash: {error: t(".required_accountant")}
  end
end
