class MessagesController < BaseController
inherit_resources
load_and_authorize_resource 
 before_filter :everypage
   respond_to :html, :xml, :json
end
