class Request < ApplicationRecord
  has_many :request_details, inverse_of: :request, dependent: :destroy
  has_many :histories, dependent: :destroy
  belongs_to :user
  belongs_to :status

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :status, prefix: true, allow_nil: true

  accepts_nested_attributes_for :request_details, allow_destroy: true

  REQUEST_PARAMS = [:user_id,
                    :title,
                    :content,
                    :currency,
                    :status_id,
                     request_details_attributes:
                     [:amount, :description, :section_name, :_destroy]].freeze

  validates :title, :content, :status_id, :currency, :request_details, presence: true
  validates_associated :request_details

  scope :by_status_and_datetime, ->{order(status_id: :asc, created_at: :desc)}
  scope :own_request, ->(user_id){where(user_id: user_id)}
end
