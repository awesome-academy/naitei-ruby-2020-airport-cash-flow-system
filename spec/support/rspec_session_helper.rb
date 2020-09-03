include SessionsHelper

module RSpecSessionHelper
  def login_as_admin
    admin = FactoryBot.create(:user, role: User.roles[:admin])
    log_in admin
  end

  def login_as_accountant
    accountant = FactoryBot.create(:user, role: User.roles[:accountant])
    log_in accountant
  end

  def login_as_manager
    manager = FactoryBot.create(:user, role: User.roles[:manager])
    log_in manager
  end

  def login_as_normal_user
    user = FactoryBot.create(:user, role: User.roles[:user])
    log_in user
  end

  def login_as_accountmanager
    accountmanager = FactoryBot.create(:user, role: User.roles[:accountmanager])
    log_in accountmanager
  end
end
