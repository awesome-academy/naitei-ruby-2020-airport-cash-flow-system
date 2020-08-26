class Accountmanager::ApplicationController < ApplicationController
  include SessionsHelper

  before_action :require_accountant_manager

  def home; end

  private

  def require_accountant_manager
    return if current_user.accountmanager?

    redirect_to root_path, flash: {error: t(".required_accountant_manager")}
  end
end
