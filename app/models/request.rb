class Request < ApplicationRecord
  include Notificable

  enum status: {pending: 1, approved: 2, paid: 3, rejected: 4, canceled: 5}
  has_many :request_details, inverse_of: :request, dependent: :destroy
  has_one :history, dependent: :destroy
  belongs_to :user

  delegate :name, to: :user, prefix: true, allow_nil: true

  accepts_nested_attributes_for :request_details, allow_destroy: true

  REQUEST_PARAMS = [:user_id,
                    :title,
                    :content,
                    :currency,
                    :status,
                     request_details_attributes:
                     [:amount, :description, :section_name, :_destroy]].freeze

  validates :title, presence: true,
                    length: {maximum: Settings.validations.request.title_max_length}
  validates :content, presence: true,
                    length: {maximum: Settings.validations.request.content_max_length}
  validates :currency, :request_details, presence: true
  validates :status, presence: true, inclusion: {in: statuses.keys}
  validates :reason, presence: true, if: :rejected?
  validates_associated :request_details

  scope :by_status_and_datetime, ->{order(status: :asc, created_at: :desc)}
  scope :own_request, ->(user_id){where(user_id: user_id)}
  scope :find_requests_by_section, ->(section_id){where user_id: User.users_section(section_id)}
  scope :except_own_request, ->(user_id){where.not user_id: user_id}
  scope :except_cancel_request, ->{where.not status: Settings.status.request.canceled}
  scope :approved_requests, ->{where status: Settings.status.request.approved}
  scope :paid_requests, ->{where status: Settings.status.request.paid}

  ransacker :created_at, type: :date do
    Arel.sql("date(`requests`.`created_at`)")
  end

  ransacker :sum_amount do
    # rubocop:disable Layout/LineLength
    Arel.sql("(SELECT SUM(`request_details`.`amount`) FROM `request_details` WHERE `request_details`.`request_id` = `requests`.`id`)")
    # rubocop:enable Layout/LineLength
  end

  def send_to_manager
    User.manager_of_section user.section_id
  end

  def send_to_accountant
    User.accountant
  end

  def paid_request! status_change, request, approver
    ActiveRecord::Base.transaction do
      request.update! status: status_change

      History.create!(
        approver: approver,
        request_id: request.id,
        paid_time: Time.now.utc
      )
    end
  rescue ActiveRecord::RecordInvalid => e
    logger e.message
  end
end
