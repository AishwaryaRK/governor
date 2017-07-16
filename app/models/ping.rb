def with_timing
  begun_at = Time.now
  response = {}
  begin
    response[:result] = yield
  rescue Exception => error
    response[:error] = error
  ensure
    ended_at           = Time.now
    response[:elapsed] = ((ended_at - begun_at).to_f * 1000.0).to_i
  end
  response
end

class Ping
  attr_reader :errors

  def initialize
    @database = {}
    @cache    = {}
    @pubsub   = {}
    @errors   = []
  end

  def check_database!
    @database = with_timing do
      result = ActiveRecord::Base.connection.execute("SELECT 'PONG' as response")
      result = result.first if result
      R_.get(result, ['response'])
    end
    @errors << @database[:error] if @database[:error]
  end

  def check_cache!
    @cache = with_timing do
      client = Redis.new(Governor.redis_credentials)
      client.ping if client
    end
    @errors << @cache[:error] if @cache[:error]
  end

  def check_pubsub!
    @pubsub = with_timing do
      client  = Redis.new(Governor.redis_credentials)
      channel = ENV['GOVERNOR_REDIS_PUBSUB_CHANNEL_PING']
      message = 'PONG'
      client.publish(channel, message)
      message
    end
    @errors << @pubsub[:error] if @pubsub[:error]
  end

  def check!
    check_database!
    check_cache!
    check_pubsub! if ENV['GOVERNOR_REDIS_PUBSUB_CHANNEL_PING'].present?
  end

  def ok?
    @errors.empty?
  end

  def to_h
    obj_hash         = {:database => @database,
                        :cache    => @cache}
    obj_hash[:pubsub] = @pubsub unless @pubsub.empty?
    obj_hash
  end
end
