class RequestDetail < ApplicationRecord
  belongs_to :request, inverse_of: :request_details

  validates :section_name, presence: true
  validates :description, presence: true
  validates :amount, presence: true, numericality: {greater_than: Settings.validations.amout_min}
  validates :request, presence: true
end
