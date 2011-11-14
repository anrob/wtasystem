class ContractMailer < ActionMailer::Base
  default :from => "fresh@sofreshentertainment.com"
  def event_info_email(user)
     mail( :to => user.email, 
           :subject => "Your Event info")
   end
   
   def send_reminder(user) 
     mail(  :bcc => user, 
            :subject => "Please Confirm Jobs",
            :body => "You have unconfirmed Events")
   end
end
