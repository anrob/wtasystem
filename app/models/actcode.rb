# -*- encoding : utf-8 -*-
class Actcode < ActiveRecord::Base
  belongs_to :management
  has_many :quotes
  has_many :users
  has_many :contracts, foreign_key: "act_code", primary_key: 'actcode'
  alias_attribute "name", "actcode"
  attr_accessible :actcode, :description, :management_id, :user_id
  validates_uniqueness_of :actcode, on: :create, message: "must be unique"
  delegate :name, to: :management, prefix: true
  default_scope order: 'actcode ASC'
  scope :getallbycompany, lambda { |acts| where("management_id = ?", acts.management_id) }
end
