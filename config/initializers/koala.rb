Koala.configure do |config|
  config.app_id = Rails.application.credentials.app_id
  config.app_secret = Rails.application.credentials.app_secret
end