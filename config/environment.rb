# -*- encoding : utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)
Encoding.default_internal = 'UTF-8'
Encoding.default_external = 'UTF-8'
# Initialize the rails application
Wtasystem::Application.initialize!
require 'ruport' # Ruby Reporting Tool
require 'ruport/acts_as_reportable' # ActiveRecord data collection for Ruport.
