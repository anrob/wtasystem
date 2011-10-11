module ApplicationHelper
  
  def days_in_month(year, month)
    (Date.new(year, 12, 31) << (12-month)).day
  end
end
