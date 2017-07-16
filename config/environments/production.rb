Rails.application.configure do
  config.cache_classes                     = true
  config.eager_load                        = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.cache_store                       = [:redis_store,
                                              Governor::redis_credentials
                                                  .merge({db:        ENV['GOVERNOR_REDIS_CACHE_DATABASE'].to_i,
                                                          namespace: ENV['GOVERNOR_REDIS_CACHE_NAMESPACE']}),
                                              {expires_in: ENV['GOVERNOR_REDIS_CACHE_EXPIRY']}]
  config.public_file_server.headers        = {
      'Cache-Control' => "public, max-age=#{ENV['GOVERNOR_REDIS_CACHE_EXPIRY']}"
  }
  config.read_encrypted_secrets            = true
  config.public_file_server.enabled        = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor              = :uglifier
  config.assets.compile                    = false
  config.log_level                         = :debug
  config.log_tags                          = [:request_id]
  config.action_mailer.perform_caching     = false
  config.i18n.fallbacks                    = true
  config.active_support.deprecation        = :notify
  config.log_formatter                     = ::Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
end