Devise.setup do |config|
  config.secret_key    = Governor::Config[:app, :devise, :secret_key]
  config.mailer_sender = Governor::Config[:app, :devise, :mailer_sender]

  require 'devise/orm/active_record'

  config.omniauth :google_oauth2,
                  Governor::Config[:app, :google, :client, :id],
                  Governor::Config[:app, :google, :client, :secret],
                  hd: Governor::Config[:app, :hosted, :domain]

  config.authentication_keys                = []
  config.case_insensitive_keys              = []
  config.strip_whitespace_keys              = []
  config.skip_session_storage               = [:http_auth]
  config.stretches                          = Rails.env.test? ? 1 : 11
  config.reconfirmable                      = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length                    = 6..128
  config.email_regexp                       = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within              = 6.hours
  config.sign_out_via                       = :delete
end
