class ApplicationMailer < ActionMailer::Base
  default from: ENV['GOVERNOR_MAILER_DEFAULT_EMAIL'] || 'governor@example.com'

  layout 'mailer'
end
