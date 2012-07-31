# -*- encoding : utf-8 -*-
class BaseController < ApplicationController
  inherit_resources
 skip_before_filter :authenticate_user!, :except => [:new, :create]
  skip_before_filter :everypage
 end
