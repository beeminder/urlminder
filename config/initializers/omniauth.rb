Rails.application.config.middleware.use OmniAuth::Builder do
  provider :beeminder, ENV["beeminder_consumer_key"], ENV["beeminder_consumer_secret"]
end