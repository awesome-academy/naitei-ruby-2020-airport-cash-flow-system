class Currency < ApplicationRecord
  def name_initial
    name.to_s
  end
end
