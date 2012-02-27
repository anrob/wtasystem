ActiveAdmin.register User do
  
  form do |f|
       f.inputs "Details" do
    
         f.inputs :email, :password, :password_confirmation, :remember_me, :actcode, :management,  :first_name, :last_name, :phone_number
       end
   
       f.buttons
     end
  
end
