class Request < ApplicationRecord
  has_many :request_details, dependent: :destroy
  has_many :histories, dependent: :destroy
  belongs_to :user
  belongs_to :status
end
