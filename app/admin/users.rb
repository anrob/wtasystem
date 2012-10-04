ActiveAdmin.register User do
  controller.authorize_resource

   menu :if => lambda { |tabs_renderer|
     controller.current_ability.can?(:manage, config.resource)
   }

  # menu :unless => proc{ user.is?(:everything) }
  #   controller.authorize_resource
    filter :email

    index do
      column :email
      column "Actions" do |post|
           link_to "View", admin_user_path(post)
         end
     end


     show do
           h3 user.email
           div do
             simple_format user.email
           end
         end

         form do |f|
           f.inputs "Details" do
           f.input :first_name
           f.input :last_name
           f.input :email
           f.input :actcode_name
           f.input :management
           f.input :roles, :as => :check_boxes,:collection =>  User::ROLES
           f.input :encrypted_password => "fhfhfhfhfhfhfhfhfhfhfhfhfhfh"
           f.buttons
         end
       end
end
