require_relative 'boot'
require_relative 'config'

require 'rails/all'

Bundler.require(*Rails.groups)

require 'chuck'

# noinspection RubyConstantNamingConvention
R_ = Rodash

module Governor
  class Application < Rails::Application
    config.load_defaults(5.1)
  end
end
