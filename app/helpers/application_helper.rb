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
end
