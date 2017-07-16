Rails.application.configure do
  config.cache_classes               = false
  config.eager_load                  = false
  config.consider_all_requests_local = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    puts '== Caching Enabled =='
    config.action_controller.perform_caching = true
    config.cache_store                       = [:redis_store,
                                                ::Governor::redis_credentials
                                                    .merge({db:        ENV['GOVERNOR_REDIS_CACHE_DATABASE'].to_i,
                                                            namespace: ENV['GOVERNOR_REDIS_CACHE_NAMESPACE']}),
                                                {expires_in: ENV['GOVERNOR_REDIS_CACHE_EXPIRY']}]
    config.public_file_server.headers        = {
        'Cache-Control' => "public, max-age=#{ENV['GOVERNOR_REDIS_CACHE_EXPIRY']}"
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
  config.action_mailer.default_url_options   = {:host => ENV['GOVERNOR_PUMA_HOST'],
                                                :port => ENV['GOVERNOR_PUMA_PORT'].to_i}
end
