class ContractMailer < ActionMailer::Base
  default :from => "fresh@sofreshentertainment.com"
  def event_info_email(user, contract, additional)
      @user = user
      @contract = contract
      @additional = additional
     mail( :to => user.email, 
           :subject => "Your Event info")
   end
   
   def send_reminder(user) 
    # @user = user
     mail(  :bcc => user, 
            :subject => "Please Confirm Jobs")
            #:body => "You have unconfirmed Events"
   end
   
   def deliver(user,contract,additional)
      event_info_email(user,contract,additional).deliver
      contract.update_attributes(:confirmation => 1)
      #handle_asynchronously :deliver
    end
end


