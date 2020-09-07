module RSpecSessionHelper
  def login_as_admin
    admin = FactoryBot.create(:user, role: User.roles[:admin])
    sign_in admin
  end

  def login_as_accountant
    accountant = FactoryBot.create(:user, role: User.roles[:accountant])
    sign_in accountant
  end

  def login_as_manager
    manager = FactoryBot.create(:user, role: User.roles[:manager])
    sign_in manager
  end

  def login_as_normal_user
    user = FactoryBot.create(:user, role: User.roles[:user])
    sign_in user
  end

  def login_as_accountmanager
    accountmanager = FactoryBot.create(:user, role: User.roles[:accountmanager])
    sign_in accountmanager
  end
end
