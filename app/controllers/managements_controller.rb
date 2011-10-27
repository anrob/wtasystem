class ManagementsController < BaseController
inherit_resources
load_and_authorize_resource #:management, :through => :contract
 before_filter :everypage
 respond_to :html, :xml, :json

end
