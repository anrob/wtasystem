# -*- encoding : utf-8 -*-
class Actcode < ActiveRecord::Base
  belongs_to :management
  has_many :users
  has_many :contracts, :foreign_key => "act_code", :primary_key => 'actcode'
  alias_attribute "name", "actcode"
 attr_accessible :actcode, :description, :management_id, :user_id
 validates_uniqueness_of :actcode, :on => :create, :message => "must be unique"
 
  default_scope :order => 'actcode ASC'
  scope :getallbycompany, lambda { |acts| where("management_id = ?", acts.management_id) }
  scope :isassigned, where("management_id IS NOT NULL")
  scope :getcontracts, lambda {
       joins(:contracts).group("actcodes.id") & Contract.tenday.all
     }
end
