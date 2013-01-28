# -*- encoding : utf-8 -*-
class Management < ActiveRecord::Base
    has_many :users
    belongs_to :user
   default_scope order: 'name ASC'
end
