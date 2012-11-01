class SessionsController < ApplicationController
layout 'staff'
  def create
    staff = Staff.from_omniauth(env["omniauth.auth"])
    session[:staff_id] = staff.id

   # @staff = Staff.all
    redirect_to staffs_path

  end

  def destroy
    session[:staff_id] = nil
    redirect_to root_url
  end



  private
   def fb_user
     @current_user ||= Staff.find(session[:staff_id]) if session[:staff_id]
   end
   helper_method :fb_user
end