class Section < ApplicationRecord
  has_many :users, dependent: :destroy
end
