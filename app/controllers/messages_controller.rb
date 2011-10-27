class MessagesController < BaseController
inherit_resources
load_and_authorize_resource 

   respond_to :html, :xml, :json
end
