class UsersController < InheritedResources::Base
  load_and_authorize_resource
  before_filter :everypage
 respond_to :html, :xml, :json
before_save :uppercase_fields
end
