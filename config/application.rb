require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

require 'chuck'

# noinspection RubyConstantNamingConvention
R_ = Rodash

module Governor
  class << self
    def redis_credentials
      credentials = {host: ENV['GOVERNOR_REDIS_HOST'],
                     port: ENV['GOVERNOR_REDIS_PORT']}
      if ENV['GOVERNOR_REDIS_PASSWORD'].present?
        credentials[:password] = ENV['GOVERNOR_REDIS_PASSWORD']
      end
      credentials
    end
  end

  class Application < Rails::Application
    config.load_defaults(5.1)
  end
end
