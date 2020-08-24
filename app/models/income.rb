class Income < ApplicationRecord
  INCOMES_PARAMS = %i(title content amount currency supplier_id).freeze

  belongs_to :user
  belongs_to :supplier
  belongs_to :status

  delegate :name, to: :status, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true

  validates :title, presence: true, length: {maximum: Settings.title.max_length}
  validates :content, presence: true, length: {maximum: Settings.content.max_length}
  validates :currency, :amount, :supplier_id, :status_id, :user_id, presence: true
  validates :amount, numericality: {greater_than: Settings.validations.amout_min}

  scope :by_status_then_created_at, ->{order status_id: :asc, created_at: :desc}
end
