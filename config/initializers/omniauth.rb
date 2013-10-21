Rails.application.config.middleware.use OmniAuth::Builder do
  provider :beeminder, ENV["beeminder_client_id"], ENV["beeminder_client_secret"]
end