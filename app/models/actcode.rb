class Actcode < ActiveRecord::Base
  belongs_to :management
  has_many :users
  scope :getallbycompany, lambda { |acts| where("management_id = ?", acts.management_id) }
end
