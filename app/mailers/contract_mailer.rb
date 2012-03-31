require 'postageapp/mailer'

class ContractMailer < PostageApp::Mailer
  default :from => "fresh@sofreshentertainment.com"
  def event_info_email(user, contract, additional)
      @user = user
      @contract = contract
      @additional = additional
      postageapp_template 'eventinfo_template'
     mail( :to => user.email, 
           :subject => "Your Event info")
   end
   
   def send_reminder(user) 
    # @user = user
    postageapp_template 'eventinfo_template'
     mail(  :to => user, 
            :subject => "Please Confirm Jobs")
            #:body => "You have unconfirmed Events"
   end
   
   def send_user_reminder(user) 
    # @user = user
    postageapp_template 'eventinfo_template'
     mail(  :to => user, 
            :subject => "Please Confirm Jobs")
            #:body => "You have unconfirmed Events"
   end
   
   def deliver(user,contract,additional)
      ContractMailer.event_info_email(user,contract,additional).deliver
      contract.update_attributes(:confirmation => 1)
    end
end


