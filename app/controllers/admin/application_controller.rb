class Admin::ApplicationController < ApplicationController
  include SessionsHelper

  before_action :require_admin

  def home; end

  private

  def require_admin
    return if current_user.admin?

    redirect_to root_path, flash: {error: t(".required_admin")}
  end
end
