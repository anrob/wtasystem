class Actcode < ActiveRecord::Base
  belongs_to :management
  # belongs_to :user
  scope :getallbycompany, lambda { |acts| where("management_id = ?", acts.management_id) }
end
