class ApplicationController < ActionController::Base
   add_breadcrumb "Home", :root_path
 before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end  
  rescue_from ActiveRecord::RecordNotFound do
    render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404
  end
  protect_from_forgery
  #check_authorization :unless => :devise_controller?
  #load_and_authorize_resource
  layout :special_layout

   # def param_posted?(sym)
   #   request.post? and params[sym]
   # end
  protected
  def special_layout
     if devise_controller?
       "special_layout"
     else
       "application"
     end
   end
   
   # def param_posted?(sym)
   #    request.post? and params[sym]
   #  end
end
