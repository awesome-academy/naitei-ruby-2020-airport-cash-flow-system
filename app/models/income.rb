class Income < ApplicationRecord
  INCOMES_PARAMS = %i(title content amount currency supplier_id).freeze

  enum status: {pending: 1, approved: 2, rejected: 3, canceled: 4}

  belongs_to :user
  belongs_to :supplier

  delegate :name, to: :status, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true

  validates :title, presence: true, length: {maximum: Settings.title.max_length}
  validates :content, presence: true, length: {maximum: Settings.content.max_length}
  validates :currency, :amount, :supplier_id, :status, :user_id, presence: true
  validates :amount, numericality: {greater_than: Settings.validations.amout_min}

  scope :by_status_then_created_at, ->{order status: :asc, created_at: :desc}
end
