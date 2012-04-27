# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  set_tab :account
  inherit_resources
   load_and_authorize_resource #:skip_authorization_check #:user, :through => :contract 
   rescue_from CanCan::AccessDenied do |exception|
     Rails.logger.error(exception, exception.backtrace)
     # :back isn't defined all the time...
     redirect_to :back, :alert => exception.message
   end
    #before_filter :everypage
   #respond_to :html, :xml, :json
 
 # def index
 #   if current_user.is? :everything
 #   @users = User.page(params[:page]).all
 # else
 #   @users = @users.page(params[:page]).all
 #  end
 #  
 # end
 

end
