class UsersController < ApplicationController
  inherit_resources
  load_and_authorize_resource
   rescue_from CanCan::AccessDenied do |exception|
     Rails.logger.error(exception)
     # :back isn't defined all the time...
     redirect_to root_url, alert: exception.message
   end
end
