# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  add_breadcrumb "Home", :root_path
  before_filter :authenticate_user!
   #load_and_authorize_resource
   protect_from_forgery
  include Mobylette::RespondToMobileRequests
   
  respond_to :html, :xml, :json
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end  
  rescue_from ActiveRecord::RecordNotFound do
      
     render :file => "#{Rails.root}/public/404.html", :layout => true, :status => 404
    
   end
   WillPaginate.per_page = 10
  #protect_from_forgery
  layout :special_layout
 
 # before_filter :prepare_for_mobile

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

  def everypage
     @management = Management.find_by_id(current_user.management_id)
     @mana = Actcode.find_by_actcode(current_user.actcode_name)
     # @manger = User.getotheracts(current_user).map {|m| m.actcode}
     @manger = Actcode.getallbycompany(current_user).map {|m| m.actcode}
     @but = @manger.include?(params[:act_code]).to_s
     @user = current_user
     @pd = @user
     # @message = Message.last
     @otheracts = User.getotheracts(current_user).order("first_name")
     @getallbycompnay = Actcode.getallbycompany(current_user).order("actcode")
     # @cp = Contract.where(:act_code => current_user.actcode)
     #      @test = @cp.mytoday.count
    # @cc = @contracts.sum(:contract_price) 
  end
  
  protected
  def special_layout
     if devise_controller? && resource_name == :admin
       "special_layout"
     else
       "application"
     end
   end
   
   # def param_posted?(sym)
   #    request.post? and params[sym]
   #  end
end
