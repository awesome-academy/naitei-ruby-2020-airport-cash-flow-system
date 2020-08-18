class UsersController < ApplicationController
  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash.now[:info] = "Account created"
      redirect_to root_url
    else
      render :new
    end
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def show; end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end
end
