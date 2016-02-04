# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
PublicUrlIntegration::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || '964cc2163a66387283c389e0fb852ceaa27617a68b5db39e8125b378f64946b2062e5d3439914d0662ac243fa758ececa7026596336888771f8195dab6f26b69'
