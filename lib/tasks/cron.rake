
desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour % 1 == 0 # run every 1 hours
    puts "Updating feed..."
    Contract.import_contracts
    puts "done."
  end
end