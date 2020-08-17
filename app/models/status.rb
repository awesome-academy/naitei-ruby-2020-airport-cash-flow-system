class Status < ApplicationRecord
  has_many :requests, dependent: :destroy
end
