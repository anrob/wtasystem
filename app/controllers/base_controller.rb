# -*- encoding : utf-8 -*-
class BaseController < ApplicationController
  inherit_resources
  load_and_authorize_resource

end
