class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale, :require_login

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def require_login
    return if logged_in?

    flash[:error] = t ".failed_login"
    redirect_to login_path
  end
end
