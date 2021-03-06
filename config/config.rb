module Governor
  class Config
    CONFIGS ={
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
            :saml_idp => {
                :x509_certificate             => 'GOVERNOR_APP_SAML_IDP_X509_CERTIFICATE',
                :secret_key                   => 'GOVERNOR_APP_SAML_IDP_SECRET_KEY',
                :organization_name            => 'GOVERNOR_APP_SAML_IDP_ORGANIZATION_NAME',
                :organization_url             => 'GOVERNOR_APP_SAML_IDP_ORGANIZATION_URL',
                :base_saml_location           => 'GOVERNOR_APP_SAML_IDP_BASE_SAML_LOCATION',
                :single_service_post_location => 'GOVERNOR_APP_SAML_IDP_SINGLE_SERVICE_POST_LOCATION',
                :response_expiry              => 'GOVERNOR_APP_SAML_IDP_RESPONSE_EXPIRY',
                :session_expiry               => 'GOVERNOR_APP_SAML_IDP_SESSION_EXPIRY',
                :sp_base                      => 'GOVERNOR_APP_SAML_IDP_SP_BASE',
                :sp_domain                    => 'GOVERNOR_APP_SAML_IDP_SP_DOMAIN',
                :sp_fingerprint               => 'GOVERNOR_APP_SAML_IDP_SP_FINGERPRINT',
                :sp_data_dog_sso_url          => 'GOVERNOR_APP_SAML_IDP_SP_DATA_DOG_SSO_URL',
                :sp_data_dog_metadata_url     => 'GOVERNOR_APP_SAML_IDP_SP_DATA_DOG_METADATA_URL',
                :sp_new_relic_sso_url         => 'GOVERNOR_APP_SAML_IDP_SP_NEW_RELIC_SSO_URL',
                :sp_new_relic_metadata_url    => 'GOVERNOR_APP_SAML_IDP_SP_NEW_RELIC_METADATA_URL',
                :sp_mixpanel_sso_url          => 'GOVERNOR_APP_SAML_IDP_SP_MIXPANEL_SSO_URL',
                :sp_mixpanel_metadata_url     => 'GOVERNOR_APP_SAML_IDP_SP_MIXPANEL_METADATA_URL',
            },
            :devise   => {
                :cas_base_url  => 'GOVERNOR_APP_DEVISE_CAS_BASE_URL',
                :secret_key    => 'GOVERNOR_APP_DEVISE_SECRET_KEY',
                :mailer_sender => 'GOVERNOR_APP_DEVISE_MAILER_SENDER'
            },
            :google   => {
                :client => {
                    :id     => 'GOVERNOR_APP_GOOGLE_CLIENT_ID',
                    :secret => 'GOVERNOR_APP_GOOGLE_CLIENT_SECRET'
                }
            },
            :hosted   => {
                :domain => 'GOVERNOR_APP_HOSTED_DOMAIN'
            }
        }
    }.freeze

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
    }.freeze

    class << self
      def [](feature)
        feature     = feature.to_s.delete('?', '').to_sym
        feature_env = FEATURES[feature]
        ENV[feature_env].present? if feature_env
      end
    end
  end

  class << self
    def redis_credentials
      credentials            = { :host => Config[:redis, :host],
                                 :port => Config[:redis, :port] }
      credentials[:password] = Config[:redis, :password] if Config[:redis, :password]
      credentials
    end
  end
end
