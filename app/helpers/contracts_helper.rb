module ContractsHelper

  def makebutton(contract)
   if contract.date_of_event < Date.today + 10.days
     if contract.confirmation == 0
     button_to ' CONFIRM THIS EVENT ', confirmjob_path(:id => contract.id), :class => 'btn-primary'
     else
     button_to 'Email Job Information', confirmjob_path(:id => contract.id), :class => 'btn-success'
     end 
     end
    #render :text => contract.confirmation
   end
end
