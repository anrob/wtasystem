# -*- encoding : utf-8 -*-
class BaseController < ApplicationController
  inherit_resources
  load_and_authorize_resource
 skip_before_filter :authenticate_user!, :except => [:new, :create]
has_mobile_fu
 skip_before_filter :everypage
 end
