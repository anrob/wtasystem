class UsersController < BaseController
   rescue_from CanCan::AccessDenied do |exception|
     Rails.logger.error(exception)
     # :back isn't defined all the time...
     redirect_to root_url, :alert => exception.message
   end
end
