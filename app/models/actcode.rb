class Actcode < ActiveRecord::Base
  belongs_to :management
  has_many :users
  has_many :contracts, :foreign_key => "act_code", :primary_key => 'actcode'
 attr_accessible :actcode, :description, :management_id, :user_id
 
  default_scope :order => 'actcode ASC'
  scope :getallbycompany, lambda { |acts| where("management_id = ?", acts.management_id) }
  
  scope :getcontracts, lambda {
       joins(:contracts).group("actcodes.id") & Contract.tenday.all
     }
end
