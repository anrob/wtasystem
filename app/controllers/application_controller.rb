class ApplicationController < ActionController::Base
  add_breadcrumb "Home", :root_path
  before_filter :authenticate_user!
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access deniedd."
    redirect_to root_url
  end  
  rescue_from ActiveRecord::RecordNotFound do
     
    render :file => "#{Rails.root}/public/404.html", :layout => true, :status => 404
   
  end
  #protect_from_forgery
  layout :special_layout

  def everypage
     @management = Management.find_by_id(current_user.management_id)
     @manger = User.getotheracts(current_user).map {|m| m.actcode}
     @but = @manger.include?(params[:act_code]).to_s
     @user = current_user
     @pd = @user
     @message = Message.last
     @otheracts = User.getotheracts(current_user).order("first_name")
    # @cc = @contracts.sum(:contract_price) 
  end
  
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
