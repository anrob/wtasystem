ActiveAdmin.register Contract do
  controller.authorize_resource

    menu :if => lambda { |tabs_renderer|
      controller.current_ability.can?(:manage, config.resource)
    }
 filter :act_booked
 filter :act_code
 filter :date_of_event
 filter :agent

 index do
   column :date_of_event
   column :contract_number
   column :clientname
   column :type_of_event
   column :location_name
   column :act_booked
   column :contract_price

 end
end
