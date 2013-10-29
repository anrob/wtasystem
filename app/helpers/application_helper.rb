# -*- encoding : utf-8 -*-
module ApplicationHelper
  def app_name
    "Confirmation System"
  end

  def days_in_month(year, month)
    (Date.new(year, 12, 31) << (12-month)).day
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def begin_weekly_calendar
     @begin_calendar = Date.today.beginning_of_week(start_day = :sunday)
   end

   def end_weekly_calendar(weeks)
     @begin_calendar = Date.today.beginning_of_week(start_day = :sunday)
     @end_calendar = @begin_calendar + (weeks*7)-1
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
