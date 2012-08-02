ActiveAdmin.register User do
  menu :if => proc{ can?(:everything, User) }
    controller.authorize_resource
end
