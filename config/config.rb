module Governor
  class Config
    CONFIGS = {
        :redis => {
            :host                  => 'GOVERNOR_REDIS_HOST',
            :port                  => 'GOVERNOR_REDIS_PORT',
            :password              => 'GOVERNOR_REDIS_PASSWORD',
            :pubsub_channel_prefix => 'GOVERNOR_REDIS_PUBSUB_CHANNEL_PREFIX',
            :cache                 => {
                :database  => 'GOVERNOR_REDIS_CACHE_DATABASE',
                :namespace => 'GOVERNOR_REDIS_CACHE_NAMESPACE',
                :expiry    => 'GOVERNOR_REDIS_CACHE_EXPIRY'
            }
        },
        :puma  => {
            :host    => 'GOVERNOR_PUMA_HOST',
            :port    => 'GOVERNOR_PUMA_PORT',
            :threads => {
                :min => 'GOVERNOR_PUMA_MIN_THREADS',
                :max => 'GOVERNOR_PUMA_MAX_THREADS'
            }
        },
        :rails => {
            :env => 'RAILS_ENV'
        },
        :app   => {
            :devise => {
                :cas_base_url  => 'GOVERNOR_APP_DEVISE_CAS_BASE_URL',
                :secret_key    => 'GOVERNOR_APP_DEVISE_SECRET_KEY',
                :mailer_sender => 'GOVERNOR_APP_DEVISE_MAILER_SENDER'
            },
            :google => {
                :client => {
                    :id     => 'GOVERNOR_APP_GOOGLE_CLIENT_ID',
                    :secret => 'GOVERNOR_APP_GOOGLE_CLIENT_SECRET'
                }
            },
            :hosted => {
                :domain => 'GOVERNOR_APP_HOSTED_DOMAIN'
            }
        }
    }

    class << self
      def [](*config)
        config_env = R_.get(CONFIGS, config)
        ENV[config_env].present? && ENV[config_env] if config_env
      end
    end
  end

  class Feature
    FEATURES = {
        :redis_pubsub_ping        => 'GOVERNOR_REDIS_PUBSUB_PING',
        :rails_serve_static_files => 'GOVERNOR_RAILS_SERVE_STATIC_FILES',
        :rails_log_to_stdout      => 'GOVERNOR_RAILS_LOG_TO_STDOUT'
    }

    class << self
      def [](feature)
        feature     = feature.to_s.gsub('?', '').to_sym
        feature_env = FEATURES[feature]
        ENV[feature_env].present? if feature_env
      end
    end
  end

  class << self
    def redis_credentials
      credentials            = {:host => Config[:redis, :host],
                                :port => Config[:redis, :port]}
      credentials[:password] = Config[:redis, :password] if Config[:redis, :password]
      credentials
    end
  end
end
