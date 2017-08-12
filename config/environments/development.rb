Rails.application.configure do
  config.cache_classes               = false
  config.eager_load                  = false
  config.consider_all_requests_local = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    puts '== Caching Enabled =='
    config.action_controller.perform_caching = true

    config.cache_store = [:redis_store,
                          ::Governor.redis_credentials
                              .merge({db:        ::Governor::Config[:redis,
                                                                    :cache,
                                                                    :database].to_i,
                                      namespace: ::Governor::Config[:redis,
                                                                    :cache,
                                                                    :namespace]}),
                          {expires_in: ::Governor::Config[:redis, :cache, :expiry]}]

    config.public_file_server.headers = {
        'Cache-Control' => "public, max-age=#{::Governor::Config[:redis, :cache, :expiry]}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store                       = :null_store
  end

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching       = false
  config.active_support.deprecation          = :log
  config.active_record.migration_error       = :page_load
  config.assets.debug                        = true
  config.assets.quiet                        = true
  config.file_watcher                        = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.default_url_options = {:host => ::Governor::Config[:puma, :host],
                                              :port => ::Governor::Config[:puma, :port].to_i}

  config.public_file_server.enabled = ::Governor::Feature[:rails_serve_static_files?]

  if ::Governor::Feature[:rails_log_to_stdout?]
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end
end
