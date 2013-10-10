# -*- encoding : utf-8 -*-
module ApplicationHelper
  def app_name
    "Confirmation System"
  end

  def days_in_month(year, month)
    (Date.new(year, 12, 31) << (12-month)).day
  end




  def isincluded

   unless @contract.nil?
      @isinclud = "normal"
    else
      @isinclud = "bold"
    end
    @isinclud

  end



end
