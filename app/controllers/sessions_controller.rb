class SessionsController < ApplicationController
  before_action :require_login, except: %i(new create)

  def new
    return unless logged_in?

    flash[:error] = t ".already_sign_in"
    redirect_to requests_path
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    authenticate user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def authenticate user
    if user&.authenticate params[:session][:password]
      log_in user
      flash[:success] = t ".success_msg"
      redirect_to root_url
    else
      flash[:error] = t ".failed_msg"
      render :new
    end
  end
end
