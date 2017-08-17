Devise.setup do |config|
  config.cas_base_url  = Governor::Config[:app, :devise, :cas_base_url]
  config.secret_key    = Governor::Config[:app, :devise, :secret_key]
  config.mailer_sender = Governor::Config[:app, :devise, :mailer_sender]

  require 'devise/orm/active_record'

  config.case_insensitive_keys              = [:email]
  config.strip_whitespace_keys              = [:email]
  config.skip_session_storage               = [:http_auth]
  config.stretches                          = Rails.env.test? ? 1 : 11
  config.reconfirmable                      = true
  config.expire_all_remember_me_on_sign_out = true
  config.email_regexp                       = /\A[^@\s]+@[^@\s]+\z/
  config.sign_out_via                       = :delete
end
