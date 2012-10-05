# -*- encoding : utf-8 -*-
require 'postageapp/mailer'
class ContractMailer < PostageApp::Mailer
  default from: "support@confirmmygig.com"
  def event_info_email(user, contract, additional)
      @user = user
      @contract = contract
      @additional = additional
      postageapp_template 'eventinfo_template'
     mail( to: user.email,
           subject: "Event info -" "#{contract.act_booked} - #{contract.contract_number} - #{contract.eventtime} - #{contract.date_of_event.to_formatted_s(:eventdate)}")
   end

   def event_info_email_with_all_money(user, contract, additional)
       @user = user
       @contract = contract
       @additional = additional
       postageapp_template 'eventinfo_template'
      mail( to: user.email,
            subject: "Event info -" "#{contract.act_booked} - #{contract.contract_number} - #{contract.eventtime} - #{contract.date_of_event.to_formatted_s(:eventdate)}")
    end


    def event_info_email_with_net_money(user, contract, additional)
        @user = user
        @contract = contract
        @additional = additional
        postageapp_template 'eventinfo_template'
       mail( to: user.email,
             subject: "Event info -" "#{contract.act_booked} - #{contract.contract_number} - #{contract.eventtime} - #{contract.date_of_event.to_formatted_s(:eventdate)}")
     end

     def event_info_email_with_no_money(user, contract, additional)
         @user = user
         @contract = contract
         @additional = additional
         postageapp_template 'eventinfo_template'
        mail( to: user.email,
              subject: "Event info -" "#{contract.act_booked} - #{contract.contract_number} - #{contract.eventtime} - #{contract.date_of_event.to_formatted_s(:eventdate)}")
      end
   def send_reminder(user)
    # @user = user
    postageapp_template 'eventinfo_template'
     mail(  from: "support@confirmmygig.com",
            to: user,
            subject: "Please Confirm Jobs")
   end

   def send_user_reminder(user)
    # @user = user
    postageapp_template 'eventinfo_template'
     mail(  from: "support@confirmmygig.com",
            to:user,
            subject: "Please Confirm Jobs")
            #body: "You have unconfirmed Events"
   end

   def newactcodes(actcodes)
     mail(  from: "support@confirmmygig.com",
            to:"iamjustfresh@gmail.com,strick@washingtontalent.com",
            subject: "New Actcodes Not in database",
            body: actcodes)
   end

   def notconfirmed(user)
      mail(  from: "support@confirmmygig.com",
             to:user,
             subject: "Dear WTA Valued Vendor",
             #body: actcodes
             )
    end

   def deliver(user,contract,additional)
      ContractMailer.event_info_email(user,contract,additional).deliver
      contract.update_attributes(confirmation: 1)
    end

  def welcome_to_family(contract)
    template_name = nil
    if contract.is_wedding?
      template_name = "welcome_wedding"
    elsif contract.is_mitzvah?
      template_name = "welcome_mitzvah"
    end
    if template_name.present?
      mail( to: contract.email_address,
            subject: "Welcome to the Washington Talent Family!",
            template_name: template_name)
    end
  end

  def level_3_mail(contract, mail_type)
    mail_type_to_subject = {
      :mitzvah_photography    => "Photography is more than the final product",
      :mitzvah_video          => "Skipping on Video Services",
      :mitzvah_green_screen   => "Washington Talent is much more than DJs and Bands",
      :mitzvah_5p_kickback    => "Dear Angel, We want to offer you something just for
being a part of the family!",
      :mitzvah_lighting       => "Transform your room with Lighting",
      :mitzvah_photo_booth    => "Washington Talent is much more than DJs and Bands",
      :mitzvah_custom_caps    => "When you are going through your checklist of what you need for your
upcoming Mitzvah do you have Cocktail Entertainment and Guest Giveaways listed
as two items",
      :mitzvah_imagine_me     => "IMAGINE ME",
      :mitzvah_sprockit_the_robot => "Sprockit the Robot",
      :mitzvah_rocking_recording_booth  => "Rockin’ Recording Booth",

      :wedding_photography    => "Photography is more than the final product",
      :wedding_video          => "Skipping on Video Services",
      :wedding_5p_kickback    => "Dear Angel, We want to offer you something just for
being a part of the family!",
      :wedding_ceremony_musicians       => "Musicians are NOT made equally",
      :wedding_lighting       => "Transform your room with Lighting",
      :wedding_photo_booth    => "Add something different to your Modern Wedding"
    }

    mail( to: contract.email_address,
          subject: mail_type_to_subject[mail_type] || "Hello from Washington Talent Agency",
          template_name: mail_type)
  end

end


