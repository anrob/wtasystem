class Log < ActiveRecord::Base
  belongs_to :contract
  default_scope order: "created_at DESC"


end
