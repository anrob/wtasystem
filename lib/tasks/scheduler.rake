desc "This task is called by the Heroku cron add-on"
task :update_contracts => :environment do
    puts "Updating feed..."
    Contract.import_contracts
    puts "done."
  end
  
  task :send_reminder => :environment do 
      Contract.send_reminders
  end
end