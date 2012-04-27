# -*- encoding : utf-8 -*-
class Management < ActiveRecord::Base
    has_many :users
   default_scope :order => 'name ASC'
end
