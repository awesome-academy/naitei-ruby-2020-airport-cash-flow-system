class Accountant::ApplicationController < ApplicationController
  include SessionsHelper

  before_action :require_accountant

  def home; end

  private

  def require_accountant
    return if current_user.is_accountant?

    redirect_to root_path, flash: {error: t(".required_accountant")}
  end
end
