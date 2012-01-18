class UsersController < BaseController
  set_tab :account
  inherit_resources
   load_and_authorize_resource #:skip_authorization_check #:user, :through => :contract 

    #before_filter :everypage
   #respond_to :html, :xml, :json
 
 def index
   if current_user.is? :everything
   @users = User.page(params[:page]).all
 else
   @users = @users.page(params[:page]).all
  end
  
 end
 

end