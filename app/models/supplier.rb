class Supplier < ApplicationRecord
  has_many :incomes, dependent: :destroy
end
