# -*- encoding : utf-8 -*-
ActiveAdmin.register Contract do

  filter :act_booked
  filter :date_of_event
  filter :unique3
  index do
      column :act_booked
      column :date_of_event
    end
end
