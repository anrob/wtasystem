class Report < ActiveRecord::Base
scope :emails, -> {where("email_address LIKE ?","%@%")}
end
