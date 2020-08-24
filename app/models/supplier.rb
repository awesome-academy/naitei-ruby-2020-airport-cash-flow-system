class Supplier < ApplicationRecord
  has_many :incomes, dependent: :destroy

  scope :sort_by_name, ->{order name: :asc}
end
