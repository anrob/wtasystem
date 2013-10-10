# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :except => [:new, :create]
  has_scope :page, default: 1
  before_filter :everypage, :except => [:new, :create]
  before_filter :prepare_for_mobile
  respond_to :html, :xml, :json
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
   redirect_to root_url
  end
  rescue_from ActiveRecord::RecordNotFound do
     render file: "#{Rails.root}/public/404.html", layout: true, status: 404
  end
 # rescue_from Exception do
 #  render layout: false, :status => 422
 #  end


  private

def http_basic_authenticate_with
  http_basic_authenticate_with :name => "wtaadmin", :password => "washington"
end

  #helper_method :mobile_device?
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
    if user_signed_in?
     #@management = Management.find_by_id(current_user.management_id)
     @mana = Actcode.find_by_actcode(current_user.actcode_name, :include => :management)
     if current_user.is? :manager
     @manger = Actcode.getallbycompany(current_user).map {|m| m.actcode}
    end
     #@but = @manger.include?(params[:act_code]).to_s
     #@user = current_user
    # @pd = @user

#     @otheracts = User.getotheracts(current_user, :include => :management).order("first_name")
      @contractfour = Contract.order(params[:sort]).tenday.all
     @getallbycompnay = Actcode.getallbycompany(current_user).order("actcode")
     #@getallbycompnay = User.management

end
end
end
