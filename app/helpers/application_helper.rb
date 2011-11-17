module ApplicationHelper
  #WillPaginate.per_page = 10

  def days_in_month(year, month)
    (Date.new(year, 12, 31) << (12-month)).day
  end
  

end
