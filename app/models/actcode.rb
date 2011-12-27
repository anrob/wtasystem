class Actcode < ActiveRecord::Base
  belongs_to :management
 has_many :users
 attr_accessible :actcode, :description
 
  default_scope :order => 'actcode ASC'
  scope :getallbycompany, lambda { |acts| where("management_id = ?", acts.management_id) }
end
