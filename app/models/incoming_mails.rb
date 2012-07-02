class IncomingMails < ActiveRecord::Base
   serialize :message_all
   serialize :message_plain
end
