class ContractDecorator < ApplicationDecorator
  decorates :contract
  
  def theeventdate
    "#{model.formatted_event_start_time}" "-" "#{model.formatted_event_end_time}" 
  end

end