class StaffsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!
  inherit_resources
layout 'staff'
  private
    def fb_user
      @current_user ||= Staff.find(session[:staff_id]) if session[:staff_id]
    end
    helper_method :fb_user
end