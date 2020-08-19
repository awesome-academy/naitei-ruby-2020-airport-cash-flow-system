class UsersController < ApplicationController
  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash.now[:info] = t ".acc_create_success"
      redirect_to root_url
    else
      render :new
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end
end
