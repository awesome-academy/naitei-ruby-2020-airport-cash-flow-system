class Status < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :incomes, dependent: :destroy
end
