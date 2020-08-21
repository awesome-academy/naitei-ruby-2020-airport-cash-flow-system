class User < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :section
  belongs_to :role

  scope :users_section, ->(ids){select(:id).where("users.section_id = ?", ids)}

  VALID_EMAIL_REGEX = Settings.validations.user.email_regex
  USERS_PARAMS = %i(name email password password_confirmation role_id section_id).freeze
  attr_accessor :remember_token

  validates :name, presence: true,
                   length: {maximum: Settings.validations.user.name_max_length}
  validates :email, presence: true,
                    length: {maximum: Settings.validations.user.email_max_length},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
                       length: {minimum: Settings.validations.user.pass_min_length},
                       allow_nil: true

  before_save :downcase_email

  has_secure_password

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def forget
    update remember_digest: nil
  end

  def is_accountant?
    role_id == Settings.validations.user.accountant_role
  end

  def is_admin?
    role_id == Settings.validations.user.admin_role
  end

  def is_manager?
    role_id == Settings.validations.user.manager_role
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  private

  def downcase_email
    email.downcase!
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
