# -*- encoding : utf-8 -*-
class ManagementsController < InheritedResources::Base
  load_and_authorize_resource
 respond_to :html, :xml, :json
end
