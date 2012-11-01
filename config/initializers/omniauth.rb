OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '291985977578305', '04d33f84a6be52f5a7c3bd2a40f1feac'
end