# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base

  before_filter :authenticate_user!, :except => [:new, :create]
  has_scope :page, default: 1
  before_filter :everypage, :except => [:new, :create]

  before_filter :force_tablet_html
  has_mobile_fu
  before_filter :prepare_for_mobile
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
  # def check_for_mobile
  #    session[:mobile_override] = params[:mobile] if params[:mobile]
  #    prepare_for_mobile if mobile_device?
  #  end
  #
   def prepare_for_mobile
     if is_mobile_device?
     prepend_view_path Rails.root + 'app' + 'views_mobile'
   end
   end

   def force_tablet_html

     session[:tablet_view] = false

   end
  #
  #  def mobile_device?
  #    if session[:mobile_override]
  #      session[:mobile_override] == "1"
  #    else
  #      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
  #      (request.user_agent =~ /webOS|Mobile/) && (request.user_agent !~ /iPad/)
  #    end
  #  end
  #  helper_method :mobile_device?
def everypage
    if user_signed_in?
     @mana = Actcode.find_by_actcode(current_user.actcode_name, :include => :management)
     if current_user.is? :manager
     @manger = Actcode.getallbycompany(current_user).map {|m| m.actcode}
    end
      @contractfour = Contract.order(params[:sort]).tenday.all
     @getallbycompnay = Actcode.getallbycompany(current_user).order("actcode")

end
end
end
