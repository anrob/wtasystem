# -*- encoding : utf-8 -*-
Wtasystem::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
  config.allow_debugging = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log
  #config.serve_static_assets = false

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  # config.after_initialize do
  #    Moonshado::Sms.configure do |config|
  #      config.api_key = "http://c4dfedefb71374a5@heroku.moonshado.com" #ENV['MOONSHADOSMS_URL']
  #    end
  # end

  # Expands the lines which load the assets
  config.assets.debug = false
  ENV['SIMPLE_WORKER_ACCESS_KEY'] = '10064cd192a56c673542b7099b4b7101'
  ENV['SIMPLE_WORKER_SECRET_KEY'] = '5208965304a4130a2c9566545b9c29c4'
  ActionMailer::Base.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               'sofreshentertainment.com',
    user_name:            'fresh@sofreshentertainment.com',
    password:             'shaina',
    authentication:       'plain',
    enable_starttls_auto: true
  }
  # ActionMailer::Base.smtp_settings = {
  #    user_name: "app1427156@heroku.com",
  #    password: "shaina",
  #    domain: "yourdomain.com",
  #    address: "smtp.sendgrid.net",
  #    port: 587,
  #    authentication: :plain,
  #    enable_starttls_auto: true
  #  }
end
