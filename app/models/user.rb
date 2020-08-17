class User < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :section
end
