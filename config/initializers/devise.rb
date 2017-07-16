Devise.setup do |config|
  config.secret_key    = ENV['GOVERNOR_APP_DEVISE_SECRET_KEY']
  config.mailer_sender = ENV['GOVERNOR_APP_DEVISE_MAILER_SENDER']

  require 'devise/orm/active_record'

  config.authentication_keys                = [:login]
  config.case_insensitive_keys              = [:login, :username, :email]
  config.strip_whitespace_keys              = [:login, :username, :email]
  config.skip_session_storage               = [:http_auth]
  config.stretches                          = Rails.env.test? ? 1 : 11
  config.reconfirmable                      = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length                    = 6..128
  config.email_regexp                       = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within              = 6.hours
  config.sign_out_via                       = :delete
end
