# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base
  default from: "fresh@washingtontalent.com"

  # send a signup email to the user, pass in the user object that contains the user's email address
  def event_info_email(user)
    mail( to: user.email,
          subject:  "Your Event info",
          @body['contract'] => contract
           )
  end
end
