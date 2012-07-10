# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  add_breadcrumb "Home", :root_path
  before_filter :authenticate_user!
  has_scope :page, default: 1
  before_filter :everypage

  respond_to :html, :xml, :json
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
  rescue_from ActiveRecord::RecordNotFound do
     render file: "#{Rails.root}/public/404.html", layout: true, status: 404
  end
 rescue_from Exception do
  render layout: false, :status => 422
  end
  private


  helper_method :mobile_device?


  def everypage
    if user_signed_in?
     @management = Management.find_by_id(current_user.management_id)
     @mana = Actcode.find_by_actcode(current_user.actcode_name)
     @manger = Actcode.getallbycompany(current_user).map {|m| m.actcode}
     @but = @manger.include?(params[:act_code]).to_s
     @user = current_user
     @pd = @user

     @otheracts = User.getotheracts(current_user).order("first_name")
     @getallbycompnay = Actcode.getallbycompany(current_user).order("actcode")

end
end
end
