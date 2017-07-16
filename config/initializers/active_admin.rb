ActiveAdmin.setup do |config|
  config.site_title            = 'Governor'
  config.authentication_method = :authenticate_user!
  config.current_user_method   = :current_user
  config.logout_link_path      = :destroy_user_session_path
  config.logout_link_method    = :delete
  config.comments              = false
  config.batch_actions         = true
  config.localize_format       = :long
end
