class ContractMailer < ActionMailer::Base
  default :from => "fresh@washingtontalent.com"
  def event_info_email(user)
     mail( :to => user.email, 
           :subject => "Your Event info")
   end
end
