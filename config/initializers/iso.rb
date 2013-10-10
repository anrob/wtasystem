# -*- encoding : utf-8 -*-
ActionController::Responder.class_eval do
  alias :to_mobile :to_html
end
