module Api
  module V1
    class ContractsController < ApplicationController
      respond_to :json

      def index
        respond_with Contract.mystuff(current_user.actcode_name).tenday.all
       #@contract = Contract.where(act_code: params[:act_code])
        # @contracts = Contract.mystuff(current_user.actcode_name).tenday.all
      end
    end
  end
end