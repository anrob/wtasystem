module Api
  module V1
    class ContractsController < ApplicationController
      skip_before_filter :authenticate_user!
      before_filter :restrict_access
      prepend_before_filter :get_auth_token
      respond_to :json

      def index
        #respond_with  Contract.where("act_code = ?", 'FRSD')
        response.headers["Pragma"] = "no-cache"
        response.headers["Cache-Control"] = "no-cache"
       respond_with  Contract.where("act_code = ?", params[:act_code])
       #respond_with  Contract.all
      end

      def show
              #respond_with Contract.all
             respond_with  Contract.find(params[:id])
            end

       private

       def restrict_access
               api_key = ApiKey.find_by_access_token(params[:access_token])
               head :unauthorized unless api_key
       end

       def get_auth_token
          if access_token = params[:access_token].blank? && request.headers["X-AUTH-TOKEN"]
            params[:access_token] = access_token
          end
        end
     end
    end
  end
