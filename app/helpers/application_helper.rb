module ApplicationHelper
  def modify_label_color status
    case status
    when :pending
      :secondary
    when :approved
      :success
    when :rejected
      :danger
    when :canceled
      :dark
    else
      :warning
    end
  end

  def currency_symbol currency
    if currency == "VND"
      "₫"
    elsif currency == "USD"
      "$"
    elsif currency == "JPY"
      "¥"
    end
  end
end
