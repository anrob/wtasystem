desc "This task is called by the Heroku cron add-on"
task update_contracts: :environment do
    puts "Updating feed..."
    Contract.import_contracts
    puts "done."
  end
  task send_reminder: :environment do
     puts "Sending Emails"
     # Contract.send_reminders
      Contract.send_reminders
     puts "done."
  end
  task send_user_reminder: :environment do
      puts "Sending Emails"
      # Contract.send_reminders
       Contract.send_user_reminders
      puts "done."
   end
   task mailchimp: :environment do
     puts "Updating Contacts"
     Contract.mailchimp
     puts "done"
   end

   task actcodecheck: :environment do
     puts "checking"
     Contract.checkactcodes
     puts "done"
   end


   task notconfirmed: :environment do
      puts "checking"
      Contract.notconfirmed
      puts "done"
    end