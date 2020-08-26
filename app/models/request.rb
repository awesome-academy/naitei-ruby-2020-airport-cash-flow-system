class Request < ApplicationRecord
  enum status: {pending: 1, approved: 2, paid: 3, rejected: 4, canceled: 5}

  has_many :request_details, inverse_of: :request, dependent: :destroy
  has_many :histories, dependent: :destroy
  belongs_to :user

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :status, prefix: true, allow_nil: true

  accepts_nested_attributes_for :request_details, allow_destroy: true

  REQUEST_PARAMS = [:user_id,
                    :title,
                    :content,
                    :currency,
                    :status,
                     request_details_attributes:
                     [:amount, :description, :section_name, :_destroy]].freeze

  validates :title, :content, :status, :currency, :request_details, presence: true
  validates :reason, presence: true, if: :rejected?
  validates_associated :request_details

  scope :by_status_and_datetime, ->{order(status: :asc, created_at: :desc)}
  scope :own_request, ->(user_id){where(user_id: user_id)}
  scope :find_requests_by_section, ->(section_id){where user_id: User.users_section(section_id)}
  scope :except_own_request, ->(user_id){where.not user_id: user_id}
end
