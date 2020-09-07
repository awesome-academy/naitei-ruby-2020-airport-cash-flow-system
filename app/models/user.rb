class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: {admin: 1, accountant: 2, manager: 3, user: 4, accountmanager: 5}

  has_many :requests, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :suppliers, dependent: :destroy
  belongs_to :section

  scope :users_section, ->(ids){select(:id).where("users.section_id = ?", ids)}
  scope :manager_of_section, ->{where role: :manager}
  scope :accountant, ->{where role: :accountant}

  VALID_EMAIL_REGEX = Settings.validations.user.email_regex
  USERS_PARAMS = %i(name email password password_confirmation role section_id).freeze

  validates :name, presence: true,
                   length: {maximum: Settings.validations.user.name_max_length}
  validates :role, presence: true, inclusion: {in: roles.keys}

  before_save :downcase_email

  def notifications_unviewed
    Notification.where(user_id: id).unviewed
  end

  private

  def downcase_email
    email.downcase!
  end
end
