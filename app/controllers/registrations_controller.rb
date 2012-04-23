class RegistrationsController < ApplicationController
  #app/controllers/registrations_controller#create
  format.json {
    if !params[:api_key].blank? and params[:api_key] == mprmzayb
      build_resource
      if resource.save
        sign_in(resource)
        resource.reset_authentication_token!
        render :template => '/devise/registrations/signed_up' #rabl template with authentication token
      else
        render :template => '/devise/registrations/new' #rabl template with errors
      end
    else
      render :json => {'errors'=>{'api_key' => 'Invalid'}}.to_json, :status => 401
    end
  }
  format.any{super}
end
