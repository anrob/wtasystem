# -*- encoding : utf-8 -*-
module ApplicationHelper
  def app_name
    "Confirmation System"
  end

  def days_in_month(year, month)
    (Date.new(year, 12, 31) << (12-month)).day
  end
  
  
  def makebutton
  if @contract.date_of_event < Date.today + 10.days
    if @contract.confirmation == 0
    button_to ' CONFIRM THIS EVENT ', confirmjob_path(:id => @contract.id), :class => 'btn-primary'
    else
    button_to 'Email Job Information', confirmjob_path(:id => @contract.id), :class => 'btn-success'
    end 
    end
  end
  
  def isincluded
  
   unless @contract.nil?
      @isinclud = "normal"
    else
      @isinclud = "bold"
    end
    @isinclud

  end
  
  def log_action(message)
        l = Contract.logs.new(:modification => message)
        l.save
    end

end
