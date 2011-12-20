class Management < ActiveRecord::Base
  has_many :users
  #has_many :actcodes
end
