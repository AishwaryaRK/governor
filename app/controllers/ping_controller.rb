class PingController < ApplicationController
  def index
    ping = Ping.new
    ping.check!
    render :json   => ping.to_h,
           :status => ping.ok? ? :ok : :service_unavailable
  end
end
