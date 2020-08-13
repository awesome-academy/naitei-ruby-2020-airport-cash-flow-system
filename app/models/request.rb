class Request < ApplicationRecord
  has_many :request_detail, dependent: :destroy
  has_many :histories, dependent: :destroy
  belongs_to :user
  belongs_to :status
end
