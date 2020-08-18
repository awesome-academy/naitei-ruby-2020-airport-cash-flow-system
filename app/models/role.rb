class Role < ApplicationRecord
  has_many :users, dependent: :destroy

  def name_initial
    name.to_s
  end
end
