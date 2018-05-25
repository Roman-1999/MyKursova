Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  # config.omniauth :github, 
  #                 ENV['GITHUB_API_KEY'], 
  #                 ENV['GITHUB_API_SECRET'], 
  #                 scope: 'user:email'

  config.omniauth :github, "e3b741465b07d79fe8c7", "d96677ee06adfc4f0d167cfe646b18ef67b876ce"
end
