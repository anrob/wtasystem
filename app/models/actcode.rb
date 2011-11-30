class Actcode < ActiveRecord::Base
  belongs_to :management
  
    scope :getallbycompany, lambda { |acts| where("management_id = ?", acts.management_id) }
end
