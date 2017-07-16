HealthMonitor.configure do |config|
  config.cache
  config.redis.configure do |redis_config|
    redis_config.url = ENV['GOVERNOR_REDIS_CABLE_URL']
  end
end
