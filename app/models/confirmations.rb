class Confirmations < ActiveRecord::Base

  attr_accessible :contract_id, :user_id, :confirmed
  belongs_to :contract
  belongs_to :user 

end
